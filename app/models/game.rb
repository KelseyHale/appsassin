class Game < ActiveRecord::Base
  belongs_to :user
  has_many :rounds
  has_many :players
  has_many :targets
  has_many :users, through: :players

  validates :name, presence: true
  validates :limit, presence: true

  def player_in_game?(game, current_user)
    game.players.each do |player|
      if player.user.id == current_user.id
        return true
      end
    end
    false
  end

  def game_winner
    self.players.each do |player|
      if player.active
        return "#{player.user.first_name} #{player.user.last_name}"
      end
    end
  end

  def active_player_count
    active_player_count = 0
    self.players.each do |player|
      if player.active
        active_player_count += 1
      end
    end
    active_player_count
  end

  def game_over?
    active_player_count == 1
  end
end
