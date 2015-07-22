class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  has_many :round_assignments
  has_many :rounds, through: :round_assignments
  has_many :targets, through: :round_assignments

  validates :user, presence: true
  validates :game, presence: true

  def target
    self.game.rounds.last.round_assignments.where(player_id: self).last.target
  end
end
