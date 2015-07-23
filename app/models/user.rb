class User < ActiveRecord::Base
  has_many :games
  has_many :players
  has_many :targets
  has_many :games, through: :players

  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, length: { is: 11, allow_blank: true }
  validates :phone_number, numericality: {
    only_integer: true,
    allow_blank: true
  }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :profile_photo, ProfilePhotoUploader
end
