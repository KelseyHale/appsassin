class GamesController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @games = Game.all
  end

  def show
    @player = Player.new
    @round = Round.new
    @target = Target.new
    @game = Game.find(params[:id])
    @players = @game.players
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.user = current_user

    if @game.save
      flash[:notice] = "#{@game.name} has been successfully created."
      Round.create(name: 0, game: @game)
      redirect_to game_path(@game)
    else
      flash[:error] = @game.errors.full_messages.join(". ")
      render :new
    end
  end

  protected

  def game_params
    params.require(:game).permit(:name, :password, :user_id, :limit)
  end
end
