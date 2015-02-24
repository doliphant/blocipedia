class WikiPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    if user
      (user.role == 'admin') || record.users.include?(user) || (user == record.user) || (record.private == false)
    else
      record.private == false
    end
  end

  class Scope < Scope
    attr_reader :user, :scope

    def initializer(user, scope)
      @user = user
      @scope = scope
    end

    def resolve

      if user == nil
        # scope for no user being signed in
        scope.where(private: false)
      elsif user.role == "admin"
        scope.all
      elsif user.role == "premium"
        # want to return a scope where user is owner, user is collaborator, and all non-private wikis

        # This works but logic is off
        scope.where("wikis.user_id = ? OR private = ?", user, false).joins(:collaborators).where("collaborators.user_id = ?", user)

        # getting close!!!
        # I think it needs to be on collaborators
        # scope.joins(:collaborators).where("wikis.user_id = ? OR wikis.private = ? OR collaborators.user_id = ?", user, false, user)
        # scope.joins(:collaborators).where("wikis.private = ? OR collaborators.user_id = ?", false)

        # demorgans attempt
        # scope.where.not(scope.where.not(private: false).joins(:collaborators).where.not( collaborators: { user_id: user } ))



        # this works
        # scope.joins(:collaborators).where("collaborators.user_id = ?", user)
        # scope.joins(:collaborators).where( collaborators: {user_id: user } )

        # These two work independently
        # scope.joins(:collaborators).where(collaborators: { user_id: user } )
        # scope.where("wikis.user_id = ? OR private = ?", user, false)

        # scope.where(user: user)
        # scope.where(private: false)


        #Arel Attempt
        # scope.where(
        #   arel_table[:user_id].eq(:user)
        #   .or(arel_table[:private].eq(false))
        #   ).joins(:collaborators)
        #   .where(arel_table[:user_id].eq(:user))

      else
        #this covers signed in public users, may be able to get rid of
        #I think my public and premium users have the same views.
        scope.where(private: false)
        #need to add test for collaborator status, should be same as
      end
    end

  end


end
