class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  validates :user, presence: true
  validates :game, presence: true

  def generate_targets(current_player)
    players = Player.all
    possible_targets = []
    players.each do |player|
      unless current_player.user_id == player.user_id
        possible_targets << player.user_id
      end
    end
    possible_targets
  end
end
