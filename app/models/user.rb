class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable

  belongs_to :user_role, class_name: 'UserRole', foreign_key: 'role_id'

  validates :full_name, :email, :login, :birthday, :country, :adress, :city, :state, :zip, presence: true
  validates_format_of :zip, with: /\A\d{5}(-\d{4})?\Z/, message: "Zip format is wrong. Shold match 5-digit or 9-dighit format"

  def role_name
    UserRoles.find(self.role_id).try(:name)
  end
end
