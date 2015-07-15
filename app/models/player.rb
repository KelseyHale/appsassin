class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  validates :user, presence: true
  validates :game, presence: true

  def generate_targets(current_player)
    players = Player.where(active: true)
    targets = Target.where(active: true)
    possible_targets = []
    # binding.pry
    players.each do |player|
      targets.each do |target|
        if current_player.user_id != target.user_id #change player.user_id to target.user_id
          possible_targets << target
        end
      end
    end
    possible_targets.uniq
  end
end
