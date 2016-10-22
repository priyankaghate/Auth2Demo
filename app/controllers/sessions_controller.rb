class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password]) #authenticate is a method provided by bcrypt that checks whether a correct password was entered.
      session[:user_id] = @user.id
      flash[:success] = "Welcome back!"
      p "................session create.............................."
      p params
      p"............................................................."
      redirect_to "http://localhost:3000/oauth/authorize?client_id=#{params['client_id']}&redirect_uri=http%3A%2F%2Flocalhost%3A3001%2Foauth%2Fcallback&response_type=code&scope=public+write"
    else
      flash[:warning] = "You have entered incorrect email and/or password."
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end
end