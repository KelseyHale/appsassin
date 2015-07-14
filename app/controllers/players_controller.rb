class PlayersController < ApplicationController
  before_action :authenticate_user!

  def index
    @game = Game.find(params[:game_id])
    redirect_to game_path(@game)
  end

  def new
    @game = Game.find(params[:game_id])
    @player = Player.new
      # binding.pry
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
