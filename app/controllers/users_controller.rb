class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save!
      redirect_to :root
    else
      render :new, status: 422
    end
  end

  def show
    @user = User.find(params[:id])

    if request.path.include?("organizations") && @user.user_type == 'dev'
      redirect_to developer_path(@user.id)
    elsif request.path.include?('developers') && @user.user_type == 'org'
      redirect_to organization_path(@user.id)
    end
  end

  private

  def user_params
    params.require(:user).permit(
    :first_name,
    :last_name,
    :org_name,
    :street_address,
    :city,
    :state,
    :zip,
    :phone,
    :website,
    :description,
    :user_type,
    :email,
    :password)
  end

end
