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

  # def send_text_new_targets
  #   @client = Twilio::REST::Client.new
  #   if self.user.phone_number != nil && self.user.phone_number != ""
  #     @client.messages.create(
  #       from: ENV['TWILIO_PHONE_NUMBER'],
  #       to: "+#{self.user.phone_number}",
  #       body: "Round #{self.game.rounds.last.name} of your game #{self.game.name} is beginning. Your new target is #{self.target.user.first_name} #{self.target.user.last_name}."
  #     )
  #   end
  # end
end

####rounds are blank for the beginning of the game.......
