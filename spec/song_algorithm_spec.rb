require 'spec_helper.rb'

feature "Retreiving next song", js: true do
  before(:each) do

    salman = create :user
    faisal = create(:user, email: 'faisal@selecta.com', password: '123', password_confirmation: '123')
    michael = create(:user, email: 'michael@selecta.com', password: '123', password_confirmation: '123')
    alex = create(:user, email: 'alex@selecta.com', password: '123', password_confirmation: '123')

    created_songs = FactoryGirl.create_list(:song, 10)

    without_me = create(:song, id: 100, soundcloud_id: 31252572)
    im_not_afraid = create(:song, id: 200, soundcloud_id: 43891342)

    Song.find(3,4,5).each {|song| salman.songs << song}
    Song.find(100,200,8,9,4).each {|song| faisal.songs << song}
    Song.find(100,200,7,4,10).each {|song| michael.songs << song}
    Song.find(100,200,8,2).each {|song| alex.songs << song}



    visit '/'
    click_link 'log in'
    fill_in 'Email', with: "salman@selecta.com"
    fill_in 'Password', with: "123"
    click_on "Log in"
  end

  scenario "User hits next after liking song" do
    visit '/#/track/31252572'
    click_on "Like"
    click_on "Next"
    expect(page).to have_content("Eminem - im not afraid")
  end

end
