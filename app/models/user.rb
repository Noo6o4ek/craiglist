class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :trackable, :validatable
  acts_as_gmappable

  belongs_to :user_role, class_name: 'UserRoles', foreign_key: 'role_id'
  has_many :adverts, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :full_name, :email, :login, :birthday, :country, :address, :city, :state, :zip, presence: true
  #validates_format_of :zip, with: /\A\d{5}(-\d{4})?\Z/, message: "Zip format is wrong. Shold match 5-digit or 9-dighit format"

  def role_name
    user_role.try(:name) || 'guest'
  end

  def gmaps4rails_address
  "#{country}, #{address}, #{city}, #{state}, #{zip}"
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.login = auth.info.nickname
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"]) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && try(:provider).blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
end
