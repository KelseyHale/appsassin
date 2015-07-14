class PlayersController < ApplicationController
  before_action :authenticate_user!

  # def player_in_game?(game)
  #   @players.each do |player|
  #     if player.user.id == current_user.id
  #       return true
  #     end
  #   end
  #   false
  # end

  def index
    @game = Game.find(params[:game_id])
    @players = @game.players

    if @game.player_in_game?(@game, current_user)
      flash[:notice] = "You are already a member of this game."
    else
      Player.create(user_id: current_user.id, game_id: @game.id)
      flash[:notice] = "You have joined the game #{@game.name}."
    end

    redirect_to game_path(@game)
  end

  def new
    @game = Game.find(params[:game_id])
    @player = Player.new
  end

  def create
    @player = Player.new
    @game = Game.find(params[:game_id])
    @user = current_user
    @player.game = @game
    @player.user = @user

    if params[:password] == @game.password
      if @player.save
        flash[:notice] = "You have joined the game #{@game.name}."
        redirect_to game_path(@game)
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
