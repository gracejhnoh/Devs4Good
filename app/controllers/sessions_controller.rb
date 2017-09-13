class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: user_params[:email])
    if @user == nil || user_params[:password] == ''
      @user = User.new
      @user.errors.add(:base, :email_or_password_incorrect, message: "Email or password incorrect.")
      render :new, status: 401
    elsif @user = login(user_params[:email], user_params[:password])
      if @user.user_type == 'dev'
        redirect_back_or_to developer_path(@user)
      else
        redirect_back_or_to organization_path(@user)
      end
    else
      @user = User.new
      @user.errors.add(:password, :password_incorrect, message: "is incorrect.")
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
