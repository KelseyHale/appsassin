class Round < ActiveRecord::Base
  belongs_to :game
  has_many :round_assignments
  has_many :players, through: :round_assignments
  has_many :targets, through: :round_assignments

  validates :name, presence: true

  def self.current_round
    Round.last
  end

  def assign_targets_to_actives(game)
    targets = game.targets.where(active: true).to_a
    players = game.players.where(active: true)
    # round = Round.last

    players.each do |player|
      if targets.last.user != player.user
        RoundAssignment.create!(
          round_id: (Round.last.id),
          player_id: player.id,
          target_id: targets.last.id
        )
        targets.pop
      else
        RoundAssignment.create!(
          round_id: (Round.last.id),
          player_id: player.id,
          target_id: targets.first.id
        )
        targets.shift
      end
      # player.send_text_new_targets
    end
  end
end
