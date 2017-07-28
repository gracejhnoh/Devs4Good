class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    if @user = login(user_params[:email], user_params[:password])
      redirect_back_or_to(:root)
    else
      render :new
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
