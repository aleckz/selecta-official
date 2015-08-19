
feature "in Song find", js: true do
  scenario "image" do
    visit '/'
    fill_in "searchstring", with: "eminem"
    click_on "find"
    click_on "Eminem - Without Me"

    expect(page).to have_css ('img[src*="https://i1.sndcdn.com/artworks-000015684337-kzwmxu-t500x500.jpg"]')
  end

  scenario "play button" do
    visit '/'
    fill_in "searchstring", with: "eminem"
    click_on "find"
    click_on "Eminem - Without Me"
    click_on "Play"

    expect(page).to have_content("Without Me")

  end

  scenario "pause button" do
    visit '/'
    fill_in "searchstring", with: "eminem"
    # byebug
    click_on "find"
    click_on "Eminem - Without Me"
    click_on "Pause"

    expect(page).to have_content("Without Me")

  end

  scenario "like button" do
    visit '/'
    click_link 'Sign up'
    fill_in 'Email', with: "testuser@test.com"
    fill_in 'Password', with: "password"
    fill_in 'Confirm Password', with: "password"
    click_on "Sign Up"
    fill_in "searchstring", with: "eminem"
    click_on "find"
    click_on "Eminem - Without Me"
    click_on "Like"

    expect(page).to have_content("Without Me")

  end

  scenario "next button" do
    visit '/'
    fill_in "searchstring", with: "eminem"
    click_on "find"
    click_on "Eminem - Without Me"
    click_on "Next"

    expect(page).to have_content("FLYIN FLYER")

  end
end
