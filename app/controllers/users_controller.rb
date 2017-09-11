class UsersController < ApplicationController
  before_action :require_login, only: [:edit, :update]
  before_action :redirect_if_incorrect_user, only: [:edit, :update]
  before_action :get_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def show
    if @user.user_type == 'org' && has_ein?
      response = HTTParty.get("https://projects.propublica.org/nonprofits/api/v2/organizations/#{@user.ein}.json")
      if response["organization"] == nil
        @ein_name = "Could not find matching organization for EIN"
      else
        @ein_name = response["organization"]["name"]
      end
    elsif @user.user_type == 'org' && !has_ein?
      @ein_name = "N/A"
    end

    if request.path.include?("organizations") && @user.user_type == 'dev'
      redirect_to developer_path(@user.id)
    elsif request.path.include?('developers') && @user.user_type == 'org'
      redirect_to organization_path(@user.id)
    end
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      login(user_params[:email], user_params[:password])
      redirect_to :root
    else
      render :new, status: 422
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      if @user.user_type == 'dev'
        redirect_to developer_path
      else
        redirect_to organization_path
      end
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(
    :image,
    :first_name,
    :last_name,
    :org_name,
    :ein,
    :street_address,
    :city,
    :state,
    :zip,
    :phone,
    :website,
    :description,
    :user_type,
    :email,
    :password,
    :password_confirmation)
  end

  def redirect_if_incorrect_user
    if (params[:id].to_i != current_user.id)
      return redirect_to root_path
    end
  end

  def get_user
    @user = User.find(params[:id])
  end

  def has_ein?
    @user.ein != '' && @user.ein != nil
  end

end
