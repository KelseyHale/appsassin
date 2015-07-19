class TargetsController < ApplicationController

  def update
    @game = Game.find(params[:game_id])
    @target = Target.find(params[:id])
    @player = Player.where(game: @game, user: @target.user).first

    if @target.update(active: false)
      @player.update(active: false)
      flash[:notice] = 'Target Eliminated'
      redirect_to authenticated_root_path
    else
      flash.now[:alert] = @target.errors.full_messages.join(":( ")
      render :dashboard
    end

    # protected
    #
    # def target_params
    #   params.require(:target).permit(:active)
    # end
  end







end
