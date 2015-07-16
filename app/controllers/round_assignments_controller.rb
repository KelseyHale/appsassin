class RoundAssignmentsController < ApplicationController

def new
  @assignment = RoundAssignment.new
end

def create
  @game = Game.find(params[:game_id])
  # binding.pry
  @players = Player.where(game_id: params[game_id])
  @used_targets = []
  # @players.each do |player|
  #   RoundAssignment.create!(round_id: 1, player_id: player.id, target_id: player.assign_target_to_player(player).id)
  #   # push target into used targets array
  # end
end

end
