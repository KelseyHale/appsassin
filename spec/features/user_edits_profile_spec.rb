require 'rails_helper'
require 'spec_helper'


# Acceptence Criteria
# [✓] I can navigate to an update page for my profile
# [✓] My profile is populated with accurate information

feature "As an authenticated user
I want to update my information
So that I can keep my profile up to date" do
  scenario "authenticated user clinks link to update information" do
    user = FactoryGirl.create(:user)
    email_update = 'newuseremail@email.com'
    visit '/'
    click_link("Sign In", match: :first)
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button('Log in')
    visit edit_user_registration_path(user)
    expect(page).to have_content("Edit User")
    fill_in 'Email', with: email_update
    attach_file "Profile Photo",
      "#{Rails.root}/spec/support/images/profile_photo.jpg"
    fill_in 'Current password', with: user.password
    click_button 'Update'
    expect(page).to have_content("Your account has been updated successfully.")
    expect(page).to have_css("img[src*='profile_photo.jpg']")
    visit edit_user_registration_path(user)
    expect(find_field('Email').value).to eq email_update
  end
end
