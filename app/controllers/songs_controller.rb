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
    @nextsong = "9851200"
    render :json => { soundcloud_id: @nextsong }
  end



  private

    def song_params
      params.require(:soundcloud_id)
    end

end
