class Game < ActiveRecord::Base
  belongs_to :user
  has_many :players
  has_many :users, through: :players

  validates :name, presence: true
end
