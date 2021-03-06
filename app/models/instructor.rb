class Instructor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:login_id]

  mount_uploader :profile_image, ProfileImageUploader
  has_many :advise_chats, dependent: :destroy

  validates :login_id, presence: true, length: { minimum: 10 }
  validates :name, presence: true, length: { maximum: 10 }
  validates :description, length: { maximum: 120 }

  def my_message?(message)
    advise_chats.exists?(id: message.id)
  end

  def already_message?(practice)
    advise_chats.exists?(practice_id: practice.id)
  end
end
