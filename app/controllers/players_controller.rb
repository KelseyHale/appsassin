class PlayersController < ApplicationController
  before_action :authenticate_user!

  def index
    @game = Game.find(params[:game_id])
    @players = @game.players

    if @game.player_in_game?(@game, current_user)
      flash[:notice] = "You are already a member of this game."
    else
      Player.create(user_id: current_user.id, game_id: @game.id)
      flash[:notice] = "You have joined the game #{@game.name}."
      Target.create(user_id: current_user.id, game_id: @game.id)
    end

    redirect_to game_path(@game)
  end

  def new
    @game = Game.find(params[:game_id])
    @player = Player.new
    @target = Target.new
  end

  def create
    @player = Player.new
    @target = Target.new
    @game = Game.find(params[:game_id])
    @user = current_user
    @player.game = @game
    @player.user = @user
    @target.game = @game
    @target.user = @user

    if params[:password] == @game.password
      if @player.save
        flash[:notice] = "You have joined the game #{@game.name}."
        redirect_to game_path(@game)
        @target.save
      else
        flash[:error] = @player.errors.full_messages.join(". ")
        render :new
      end
    else
      flash[:error] = "Incorrect password"
      render :new
    end
  end
end
