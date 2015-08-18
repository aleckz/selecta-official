class SongsController < ApplicationController

  respond_to :html, :json

  skip_before_filter  :verify_authenticity_token

  def index
  end

  def create
    if Song.find_by(soundcloud_id: song_params)
      current_user.songs << Song.find_by(soundcloud_id: song_params) unless current_user.songs.includes(:songs).where('soundcloud_id = ?', song_params)
    else
      current_user.songs.create(soundcloud_id: song_params)
    end
      render json: { :success => true }
  end

  def find
    oldsong = Song.find_by(soundcloud_id: song_params)
    songarray = []
    count = Hash.new(0)
    oldsong_users = oldsong.users.where('id != ?', current_user.id).to_a
    oldsong_users_songs = oldsong_users.map{|user| user.songs}.flatten
    oldsong_users_songs_wo_old_song = oldsong_users_songs.reject{|song| (song.soundcloud_id == song_params.to_i)}
    oldsong_users_songs_wo_old_song.each {|song| songarray << song}
    songarray.each {|song| count[song] +=1}
    @nextsong = count.sort_by {|k,v| v}.last
    render :json => { soundcloud_id: @nextsong[0].soundcloud_id }
  end



  private

    def song_params
      params.require(:soundcloud_id)
    end

end
