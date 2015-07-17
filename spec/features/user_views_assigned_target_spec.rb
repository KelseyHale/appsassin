require 'rails_helper'

# Acceptance criteria
#
# [] User must be logged in
# [] User only sees the target assigned to them for that round
# [] Targets are only assigned to one user at a time

feature "As a user
I want to view my target
So I know who to eliminate" do
  scenario "user visits game details page and sees their assigned target" do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    user3 = FactoryGirl.create(:user)
    user4 = FactoryGirl.create(:user)
    FactoryGirl.create(:user)
    game = FactoryGirl.create(:game)
    game2 = FactoryGirl.create(:game)
    Player.create(user: user, game: game)
    Player.create(user: user2, game: game)
    Player.create(user: user3, game: game)
    Player.create(user: user4, game: game, active: false)
    Player.create(user: user3, game: game2)
    Target.create(user: user, game: game)
    Target.create(user: user2, game: game)
    Target.create(user: user3, game: game)
    Target.create(user: user4, game: game, active: false)
    Target.create(user: user4, game: game2)
    Round.create(name: 1, game: game)

  end
end
