require 'rails_helper'

feature "As a game player
I want to see the winner of the game
When the game is over" do
  scenario "the game is over and the winner is announced" do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    game = FactoryGirl.create(:game)
    player = Player.create(user: user, game: game)
    Player.create(user: user2, game: game, active: false)
    round = Round.create(name: 1, game: game)
    Target.create(user: user, game: game)
    target2 = Target.create(user: user2, game: game)
    RoundAssignment.create!(
      round_id: round.id,
      player_id: player.id,
      target_id: target2.id
    )

    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    visit game_path(game)

    expect(page).to have_content "#{user.first_name} #{user.last_name} wins!"
  end
end
