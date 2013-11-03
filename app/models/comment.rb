class Comment < ActiveRecord::Base
  belongs_to :advert
  belongs_to :user

  validates_presence_of :body
end
