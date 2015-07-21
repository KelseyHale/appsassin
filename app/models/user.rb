class User < ActiveRecord::Base
  has_many :games
  has_many :players
  has_many :targets
  has_many :games, through: :players

  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :zip_code, length: { is: 11 }
  validates :zip_code, numericality: { only_integer: true }  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :profile_photo, ProfilePhotoUploader
end
