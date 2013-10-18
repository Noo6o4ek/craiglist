class UserRoles < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :users, foreign_key: 'role_id'
end
