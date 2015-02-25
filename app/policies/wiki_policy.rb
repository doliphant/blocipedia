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
        scope.eager_load(:collaborators)
          .where("wikis.user_id = ? OR private = ? OR collaborators.user_id = ?", user, false, user).order('wikis.created_at DESC')
      else
        #this covers signed in public users, may be able to get rid of
        #I think my public and premium users have the same views.
        scope.where(private: false)
        #need to add test for collaborator status, should be same as
      end
    end

  end


end
