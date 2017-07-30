class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: user_params[:email])
    if @user == nil || user_params[:password] == ''
      @user = User.new
      render :new, status: 401
    elsif @user = login(user_params[:email], user_params[:password])
      redirect_back_or_to(:root)
    else
      render :new, status: 401
    end
  end

  def destroy
    logout
    redirect_to(:root)
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end

end
