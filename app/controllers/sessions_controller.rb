class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:email],
                             params[:password])
    if user
      session[:user_id] = user.id
      flash[:notice] = 'Successfuly Logged in!'
      redirect_to root_url
    else
      flash[:notice] = 'Invalid e-mail or password'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
    flash[:notice] = 'See you later!'
  end
end
