class Target < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  has_many :round_assignments
  has_many :rounds, through: :round_assignments
  has_many :players, through: :round_assignments

  validates :user, presence: true
  validates :game, presence: true
end
