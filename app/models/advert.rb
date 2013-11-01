class Advert < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  #Paperclip configuration
  has_attached_file :image, :styles => { medium: "300x300>", thumb: "100x100>" },
                    :url => "/system/:attachment/:id/:style/:basename.:extension",
                    :path => "/system/:attachment/:id/:style/:basename.:extension",
                    :storage => :dropbox,
                    :dropbox_credentials => Rails.root.join("config/dropbox.yml")

  acts_as_taggable

  validates_presence_of :user_id, base: "You should be logged in to create adverts"
end
