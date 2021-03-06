class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :collaborators
  has_many :collaborations, through: :collaborators, source: :wiki
  has_many :wikis

  after_initialize :set_role

  def admin?
    role == 'admin'
  end

  def premium?
    role == 'premium'
  end

  def public?
    role == 'public'
  end

  # sets default role on creation if null
  def set_role
    self.role ||= 'public'
  end

end
