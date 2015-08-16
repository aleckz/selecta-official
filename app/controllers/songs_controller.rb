class SongsController < ApplicationController

  respond_to :html, :json

  skip_before_filter  :verify_authenticity_token

  def index
  end

  def create
    @usersong = current_user.songs.create(soundcloud_id: song_params)
  end


  def find
    @oldsong = Song.find_by(soundcloud_id: song_params)
    @newsong = '12345678'
    render :json => { song: @newsong }
  end
end
