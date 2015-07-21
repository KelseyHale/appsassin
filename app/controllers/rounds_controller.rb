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
      if player.user.phone_number != nil
        @client.messages.create(
          from: ENV['TWILIO_PHONE_NUMBER'],
          to: "+#{player.user.phone_number}",
          body: "please work"
        )
      end
    end
    redirect_to game_path(@game)
  end
end
