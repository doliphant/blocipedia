class Wiki < ActiveRecord::Base
  has_many :collaborators, dependent: :destroy
  has_many :users, through: :collaborators
  belongs_to :user

  scope :default_order, -> () { order('created_at DESC') }
  scope :visible_to, -> (user) { user ? all : where(private: false) }

end
