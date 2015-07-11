require 'rails_helper'

feature "as a user
i want to create a new game
so that friends can join my game" do
  scenario 'an authenticated user adds a game and is redirected to the new games show page' do
    user = FactoryGirl.create(:user)
    game = FactoryGirl.create(:game)
    visit '/'
    click_on "View created games"
    expect(page).to have_content game.name
  end
end
