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
  and the game is not yet full" do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    FactoryGirl.create(:user)
    FactoryGirl.create(:user)
    FactoryGirl.create(:user)
    game = FactoryGirl.create(:game, user: user, limit: 4)
    player = Player.create(user: user, game: game)
    player2 = Player.create(user: user2, game: game)
    Target.create(user: user, game: game)
    Target.create(user: user2, game: game)

    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    click_link "View created games"
    click_link game.name
    expect(page).to have_content player.user.first_name
    expect(page).to have_content player2.user.first_name
    expect(page).to_not have_button "Start game"
    expect(page).to have_content "Waiting on 2 player(s)"
  end
  scenario "game owner visits game details page,
  the game is full,
  clicks start game button and targets are assigned to users" do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    user3 = FactoryGirl.create(:user)
    user4 = FactoryGirl.create(:user)
    FactoryGirl.create(:user)
    game = FactoryGirl.create(:game, user: user, limit: 4)
    player = Player.create(user: user, game: game)
    player2 = Player.create(user: user2, game: game)
    Target.create(user: user, game: game)
    Target.create(user: user2, game: game)
    player3 = Player.create(user: user3, game: game)
    player4 = Player.create(user: user4, game: game)
    Target.create(user: user3, game: game)
    Target.create(user: user4, game: game)

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
