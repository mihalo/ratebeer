class SessionsController < ApplicationController

  def new
    #kirjautumissivu
  end

  def create
    user = User.find_by username: params[:username]
    if user && user.authenticate(params[:password])
      if user.ban
        redirect_to signin_path, notice: "Your account is frozen, please contact admin"
      else
        session[:user_id] = user.id
        redirect_to user_path(user), notice: "Welcome back!"
      end
    else
      redirect_to :back, notice: "Username and/or password mismatch"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end
