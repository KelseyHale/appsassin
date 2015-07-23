class RoundsController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    @players = @game.players
    @client = Twilio::REST::Client.new
    if @game.rounds == []
      @round = Round.new(name: 1, game: @game)
    else
      @round = Round.new(name: (@game.rounds.last.name + 1), game: @game)
    end

    if @round.save
      flash[:notice] = "The game has begun."
      redirect_to game_path(@game)
      @round.assign_targets_to_actives(@game)
    else
      flash[:error] = "error"
    end
  end
end
