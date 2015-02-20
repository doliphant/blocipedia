class WikiPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    (user.role == 'admin') || record.users.include?(user) || (user == record.user)
  end

end
