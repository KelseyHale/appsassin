class TargetsController < ApplicationController
  def update
    @game = Game.find(params[:game_id])
    @target = Target.find(params[:id])
    @player = Player.where(game: @game, user: @target.user).first
    @players = Player.where(game: @game)
    @active_players = @game.active_player_count
    @client = Twilio::REST::Client.new

    if @target.update(active: false)
      @player.update(active: false)
      flash[:notice] = 'Target Eliminated'
      if @active_players == 2
        @players.each do |player|
          if player.user.phone_number != nil && player.user.phone_number != ""
            @client.messages.create(
              from: ENV['TWILIO_PHONE_NUMBER'],
              to: "+#{player.user.phone_number}",
              body: "GAME OVER (#{@game.name})--
              #{@players.where(active: true).last.user.first_name}
              #{@players.where(active: true).last.user.last_name} wins!"
            )
          end
        end
      end
      redirect_to authenticated_root_path
    else
      flash.now[:alert] = @target.errors.full_messages.join(":( ")
      render :dashboard
    end
  end
end
