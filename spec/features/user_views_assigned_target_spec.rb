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
    user5 = FactoryGirl.create(:user)
    game = FactoryGirl.create(:game)
    game2 = FactoryGirl.create(:game)
    player = Player.create(user: user, game: game)
    player2 = Player.create(user: user2, game: game)
    player3 = Player.create(user: user3, game: game)
    player4 = Player.create(user: user4, game: game, active: false)
    player5 = Player.create(user: user3, game: game2)
    target = Target.create(user: user, game: game)
    target2 = Target.create(user: user2, game: game)
    target3 = Target.create(user: user3, game: game)
    target4 = Target.create(user: user4, game: game, active: false)
    target4 = Target.create(user: user4, game: game2)
    round1 = Round.create(name: 1, game: game)


  end
end
