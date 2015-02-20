class WikiPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    (user.role == 'admin') || record.users.include?(user) || (user == record.user)
  end

  class Scope < Scope
    attr_reader :user, :scope

    def initializer(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      #need to handle non-signed in viewers
      if user.role == "admin"
        scope.all
      elsif user.role == "premium"
        scope.where(:user => user)
        # scope.where(:private => false)
      else
        #this covers signed in public users
        scope.where(:private => false)
      end
    end

  end


end
