class RoundsController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    @round = Round.current_round
    @players = @game.players

    if @game.rounds == []
      @round = Round.create(name: 1, game: @game)
      flash[:notice] = "The game has begun."
    else
      @round = Round.create(name: (@game.rounds.last.name + 1), game: @game)
    end

    Round.assign_targets_to_actives(@game)

    redirect_to game_path(@game)
  end
end
