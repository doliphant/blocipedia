class WikiPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    (record.private != true) || (user.role == 'admin') || (user.role =='premium')
  end

end
