class Song < ApplicationRecord
  mount_uploader :thumbnail, ThumbnailUploader
  mount_uploader :voice, AudioFileUploader

  belongs_to :user
  has_many :likes
  has_many :liked_user, through: :likes, source: :user

  validates :title, presence: true, length: { maximum: 20 }
  validates :description, length: { maximum: 300 }
end
