require 'rails_helper'

# Acceptance criteria
#
# [√] Current_user must be game owner
# [√] When game owner starts game targets
# are assigned to active players in round
# [√] Targets are only assigned to one user at a time

feature "As a game owner
Start the game
So targets will be assigned to players" do
  scenario "game owner visits game details page,
  clicks start game button and targets are assigned to users" do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    user3 = FactoryGirl.create(:user)
    user4 = FactoryGirl.create(:user)
    FactoryGirl.create(:user)
    game = FactoryGirl.create(:game, user: user)
    game2 = FactoryGirl.create(:game)
    player = Player.create(user: user, game: game)
    player2 = Player.create(user: user2, game: game)
    player3 = Player.create(user: user3, game: game)
    player4 = Player.create(user: user4, game: game, active: false)
    Player.create(user: user3, game: game2)
    Target.create(user: user, game: game)
    Target.create(user: user2, game: game)
    Target.create(user: user3, game: game)
    Target.create(user: user4, game: game, active: false)
    Target.create(user: user4, game: game2)

    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    click_link "View created games"
    click_link game.name
    expect(page).to have_content player.user.first_name
    expect(page).to have_content player2.user.first_name
    expect(page).to have_content player3.user.first_name
    expect(page).to have_content player4.user.first_name

    click_button "Start game"

    expect(page).to have_content "Round 1"
    expect(page).to have_content "The game has begun."
  end
end
