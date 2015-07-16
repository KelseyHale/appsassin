class Round < ActiveRecord::Base
  belongs_to :game
  has_many :round_assignments
  has_many :players, through: :round_assignments
  has_many :targets, through: :round_assignments

  validates :name, presence: true
end
