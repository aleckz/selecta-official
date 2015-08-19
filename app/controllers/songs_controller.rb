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
    flag = true

    oldsong = Song.find_by(soundcloud_id: song_params)

    ordered_liked_songs = current_user.songs.sort_by {|song| song.created_at}

    if !oldsong && ordered_liked_songs
      oldsong = ordered_liked_songs.last
    elsif !oldsong
      flag = false
    end

    session[:played_songs] += (song_params.to_s + ',')

    if flag
      songarray = []
      session[:played_songs] += (song_params.to_s + ',')
      played_songs = session[:played_songs].split(',')
      count = Hash.new(0)
      oldsong_users = oldsong.users.where('id != ?', current_user.id).to_a
      oldsong_users_songs = oldsong_users.map{|user| user.songs}.flatten
      oldsong_users_songs_wo_old_song = oldsong_users_songs.reject{|song| played_songs.include?(song.soundcloud_id.to_s)}
      oldsong_users_songs_wo_old_song.each {|song| songarray << song}
      songarray.each {|song| count[song] +=1}
      @nextsong = count.sort_by {|k,v| v}.last
      render :json => { soundcloud_id: @nextsong[0].soundcloud_id }
    end
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
