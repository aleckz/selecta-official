require 'spec_helper.rb'

feature "Searching for songs", js: true do
  scenario "finding songs" do
    visit '/'
    fill_in "searchstring", with: "eminem"
    click_on "Search"

    expect(page).to have_content("Without Me")
  end
end

feature "New user", js: true do
  before(:each) do
    visit '/'
    click_link 'Sign up'
    fill_in 'Email', with: "testuser@test.com"
    fill_in 'Password', with: "password"
    fill_in 'Password confirmation', with: "password"
    click_on "Sign Up"
  end

  scenario "User signs up" do
      expect(page).to have_content("Welcome to Selecta")
      expect(User.count).to eq(1)
  end



end
