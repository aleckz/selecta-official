require 'spec_helper.rb'

feature "Searching for songs", js: true do
  scenario "finding songs" do
    visit '/'
    fill_in "searchstring", with: "eminem"
    click_on "Search"

    expect(page).to have_content("Without Me")
  end
end
