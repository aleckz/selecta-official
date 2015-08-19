class SongsController < ApplicationController

  respond_to :html, :json

  skip_before_filter  :verify_authenticity_token

  def index
    session[:played_songs] = ''
  end

  def create
    liked_song = Song.find_by(soundcloud_id: song_params)
    session[:liked_song] = liked_song
    session[:counter] = -1
    if liked_song
      current_user.songs << liked_song unless current_user.songs.find_by(soundcloud_id: liked_song.soundcloud_id)
    else
      current_user.songs.create(soundcloud_id: song_params)
    end
      render json: { :success => true }
  end

  def find
    if session[:liked_song] == Song.find_by(soundcloud_id: song_params)
      @liked_song = Song.find_by(soundcloud_id: song_params)
      get_next_song
      @nextsong = session[:playlist][session[:counter]]
      byebug
      render :json => { soundcloud_id: @nextsong[0].soundcloud_id, liked_status: true }
    elsif session[:liked_song]
      session[:counter] -= 1
      @nextsong = session[:playlist][session[:counter]]
      byebug
      render :json => { soundcloud_id: @nextsong[0].soundcloud_id, liked_status: true }
    else
      render :json => { liked_status: false }
    end
  end


  def get_next_song
    songarray = []
    count = Hash.new(0)
    liked_song_users = @liked_song.users.where('id != ?', current_user.id).to_a
    liked_song_users_songs = liked_song_users.map{|user| user.songs}.flatten
    liked_song_users_songs_wo_liked_song = liked_song_users_songs.reject{|song| (song.soundcloud_id == song_params.to_i)}
    liked_song_users_songs_wo_liked_song.each {|song| songarray << song}
    songarray.each {|song| count[song] +=1}
    session[:playlist] = count.sort_by {|k,v| v}
  end


  #
  #   oldsong = Song.find_by(soundcloud_id: song_params) if Song.find_by(soundcloud_id: song_params)
  #   liked_status = current_user.songs.exists?(oldsong)
  #   songarray = []
  #   count = Hash.new(0)
  #   oldsong_users = oldsong.users.where('id != ?', current_user.id).to_a
  #   oldsong_users_songs = oldsong_users.map{|user| user.songs}.flatten
  #   oldsong_users_songs_wo_old_song = oldsong_users_songs.reject{|song| (song.soundcloud_id == song_params.to_i)}
  #   oldsong_users_songs_wo_old_song.each {|song| songarray << song}
  #   songarray.each {|song| count[song] +=1}
  #   @nextsong = count.sort_by {|k,v| v}.last
  #   render :json => { soundcloud_id: @nextsong[0].soundcloud_id, liked_status: liked_status }
  # end



  private

    def song_params
      params.require(:soundcloud_id)
    end

end
