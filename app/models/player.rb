class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  has_many :round_assignments
  has_many :rounds, through: :round_assignments
  has_many :targets, through: :round_assignments

  validates :user, presence: true
  validates :game, presence: true

  def generate_targets(current_player)
    targets = Target.where(game_id: current_player.game_id, active: true)
    possible_targets = []
    targets.each do |target|
      if current_player.user_id != target.user_id
        possible_targets << target
      end
    end
    possible_targets #= possible_targets - used_targets(current_player)
  end

  def assign_target_to_player(current_player)
    generate_targets(current_player).sample
  end
end
