class RoundsController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    @round = Round.current_round
    @players = @game.players
    @client = Twilio::REST::Client.new

    if @game.rounds == []
      @round = Round.create(name: 1, game: @game)
      flash[:notice] = "The game has begun."
    else
      @round = Round.create(name: (@game.rounds.last.name + 1), game: @game)
    end

    Round.assign_targets_to_actives(@game)

    @players.each do |player|
      if player.user.phone_number != nil && player.user.phone_number != ""
        @client.messages.create(
          from: ENV['TWILIO_PHONE_NUMBER'],
          to: "+#{player.user.phone_number}",
          body: "Round #{@round.name} of your game #{@game.name} is beginning. Your new target is #{player.target.user.first_name} #{player.target.user.last_name}."
        )
      end
    end
    redirect_to game_path(@game)
  end
end
