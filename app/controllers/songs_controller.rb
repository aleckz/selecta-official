class SongsController < ApplicationController

  respond_to :html, :json

  skip_before_filter  :verify_authenticity_token

  def index
  end

  def create
    @usersong = current_user.songs.create(soundcloud_id: song_params)
    if @usersong.save
      render json: { :success => true }
    end
  end


  def find
    @oldsong = Song.find_by(soundcloud_id: song_params)
    songarray = []
    count = Hash.new(0)
    @oldsong.users.to_a.each {|user| user.songs.each{|song| songarray << song if song.id != 1} }
    songarray.each {|song| count[song] +=1}
    @nextsong = count.sort_by {|k,v| v}.last
    byebug
    render :json => { soundcloud_id: @nextsong.soundcloud_id }
  end



  private

    def song_params
      params.require(:soundcloud_id)
    end

end
