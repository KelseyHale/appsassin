class Game < ActiveRecord::Base
  belongs_to :user
  has_many :players
  has_many :targets
  has_many :users, through: :players

  validates :name, presence: true

  def player_in_game?(game, current_user)
    game.players.each do |player|
      if player.user.id == current_user.id
        return true
      end
    end
    false
  end
end
