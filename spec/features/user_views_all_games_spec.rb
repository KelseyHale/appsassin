require 'rails_helper'

feature "As a user
  I want to view a list of created games
  So that I can decide to join one." do
  scenario 'user visits page and sees a list of all active games' do
    FactoryGirl.create(:user)
    game = FactoryGirl.create(:game)
    visit '/'
    click_on "View created games"
    expect(page).to have_content "Appsassin"
    expect(page).to have_content game.name
  end
end
