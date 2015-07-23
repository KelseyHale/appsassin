class RoundAssignment < ActiveRecord::Base
  after_create :send_text_new_targets
  belongs_to :round
  belongs_to :player
  belongs_to :target

  validates_associated :round
  validates_associated :player
  validates_associated :target

  def send_text_new_targets
    @client = Twilio::REST::Client.new
    if self.player.user.phone_number != nil && self.player.user.phone_number != ""
      @client.messages.create(
        from: ENV['TWILIO_PHONE_NUMBER'],
        to: "9408397009",
        body: "hey #{self.player.user.first_name}! Round #{self.round.name} of your game #{self.round.game.name} is beginning. Your new target is #{self.target.user.first_name} #{self.target.user.last_name} "
      )
    end
  end
end
