require 'spec_helper.rb'

feature "Retreiving next song", js: true do
  before(:each) do

    @salman = create :user
    faisal = create(:user, email: 'faisal@selecta.com', password: '123', password_confirmation: '123')
    michael = create(:user, email: 'michael@selecta.com', password: '123', password_confirmation: '123')
    alex = create(:user, email: 'alex@selecta.com', password: '123', password_confirmation: '123')

    created_songs = FactoryGirl.create_list(:song, 10)

    without_me = create(:song, id: 100, soundcloud_id: 31252572)
    im_not_afraid = create(:song, id: 200, soundcloud_id: 43891342)
    numb = create(:song, id: 300, soundcloud_id: 6857125)
    new_divide = create(:song, id: 400, soundcloud_id: 50623988)

    Song.find(400,3,4,5).each {|song| @salman.songs << song}
    Song.find(100,200,8,9,4).each {|song| faisal.songs << song}
    Song.find(100,200,7,4,10).each {|song| michael.songs << song}
    Song.find(100,200,8,2).each {|song| alex.songs << song}

    visit '/'
    click_link 'Log in'
    fill_in 'Email', with: "salman@selecta.com"
    fill_in 'password', with: "123"
    click_button "Log in"
  end

  describe "User hits next after liking song" do
    before(:each) do
      visit '/#/track/31252572'
      click_on "Like"
      click_on "Next"
    end

    it "finds the right song" do
      expect(page).to have_content("Eminem - im not afraid")
    end

  end

  describe "User likes a new song not in database" do
    before(:each) do
      visit '/#/track/27580789'
    end

    it "increases user's song count" do
      expect{click_on "Like"}.to change(@salman.songs,:count).by(1)
    end

    it "increases overall song count" do
      expect{click_on "Like"}.to change(Song,:count).by(1)
    end
  end

  describe "User likes a song in the database" do
    it "increases overall song count" do
      visit '/#/track/6857125'
      expect{click_on "Like"}.to change(Song,:count).by(0)
    end
  end

  describe "User likes a song they have liked before" do
    before(:each) do
      visit '/#/track/50623988'
    end

    it "does not increase user's song count" do
      expect{click_on "Like"}.to change(@salman.songs,:count).by(0)
    end

    it "does not increase overall song count" do
      expect{click_on "Like"}.to change(Song,:count).by(0)
    end

  end

end
