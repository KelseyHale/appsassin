require 'rails_helper'

feature "As a user
  I want to view the homepage
  So that I can navigate to create, join, or view other games" do
  scenario 'user visits homepage' do
    visit '/'
    expect(page).to have_content "Appsassin"
    expect(page).to have_content "Create new game"
    expect(page).to have_content "View created games"    
  end
end
