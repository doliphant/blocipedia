class WikiPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    (record.private != true) || (user.role == 'admin') ||
    record.users.include?(user)
  end

end
