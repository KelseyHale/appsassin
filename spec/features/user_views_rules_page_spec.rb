require 'rails_helper'
require 'spec_helper'

feature "As a user
  I want to visit the rules page
  And see an explanation of the game." do
  scenario 'user visits rules page' do
    visit '/'
    click_on 'Rules'
    expect(page).to have_content "Appsassin"
    expect(page).to have_content "Rules"
    expect(page).to have_content "How to play"
  end
end
