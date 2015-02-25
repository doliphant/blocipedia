class Wiki < ActiveRecord::Base
  has_many :collaborators, dependent: :destroy
  has_many :users, through: :collaborators
  belongs_to :user

  scope :default_order, -> () { order('wikis.created_at DESC') }
end
