class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # log in
    else
      # Error messages
      flash.now[:danger] = 'Invalid email/password confirmation'
      render 'new'
    end
  end

  def destroy
  end
end
