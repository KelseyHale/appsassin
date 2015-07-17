require 'rails_helper'

# Acceptance criteria
#
# [√] User must be logged in
# [√] User only sees all targets assigned to them for each game they are playing
# [√] Targets are only assigned to one user at a time per round

feature "As a user
I want to view my target
So I know who to eliminate" do
  scenario "user visits game details page and sees their assigned target" do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)

    game = FactoryGirl.create(:game, user: user)
    player = Player.create(user: user, game: game)
    Player.create(user: user2, game: game)
    Target.create(user: user, game: game)
    target = Target.create(user: user2, game: game)
    round = Round.create(name: 1, game: game)
    RoundAssignment.create!(
      round_id: round.id,
      player_id: player.id,
      target_id: target.id
    )

    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    expect(page).to have_content "Your current targets:"
    expect(page).to have_content target.user.first_name
  end
end
