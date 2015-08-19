

feature "Searching for songs", js: true do
  scenario "finding songs" do
    visit '/'
    fill_in "searchstring", with: "eminem"
    click_on "find"

    expect(page).to have_content("Eminem - Without Me")
  end

  scenario "User signs up" do
      visit '/'
      click_link 'Sign up'
      fill_in 'Email', with: "testuser@test.com"
      fill_in 'Password', with: "password"
      fill_in 'Confirm Password', with: "password"
      click_on "Sign Up"
      expect(page).to have_content("Welcome to Selecta")
      expect(User.count).to eq(1)
  end

  scenario "finding title" do
    visit '/'
    fill_in "searchstring", with: "eminem"
    click_on "find"
    click_on "Eminem - Without Me"

    expect(page).to have_content("Without Me")
  end
end
