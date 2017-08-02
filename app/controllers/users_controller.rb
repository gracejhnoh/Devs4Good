class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    if @user.user_type == 'org' && (@user.ein != '' && @user.ein != nil)
      response = HTTParty.get("https://projects.propublica.org/nonprofits/api/v2/organizations/#{@user.ein}.json")
      if response["organization"] == nil
        @ein_name = "Could not find matching organization for EIN"
      else
        @ein_name = response["organization"]["name"]
      end
    elsif @user.user_type == 'org' && (@user.ein == '' || @user.ein == nil)
      @ein_name = "N/A"
    end

    if request.path.include?("organizations") && @user.user_type == 'dev'
      redirect_to developer_path(@user.id)
    elsif request.path.include?('developers') && @user.user_type == 'org'
      redirect_to organization_path(@user.id)
    end
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save!
      @user = login(user_params[:email], user_params[:password])
      redirect_to :root
    else
      render :new, status: 422
    end
  end

  def edit
    if (params[:id].to_i != current_user.id)
      redirect_to root_path
    else
      @user = User.find(params[:id])
    end
  end

  def update
    if (params[:id].to_i != current_user.id)
      redirect_to root_path
    else
      @user = User.find(params[:id])
      if @user.update(
        user_params
        )
        if @user.user_type == 'dev'
          redirect_to developer_path
        else
          redirect_to organization_path
        end
      else
        render :edit
      end
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

end
