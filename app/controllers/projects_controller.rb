class ProjectsController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
  before_action :redirect_if_incorrect_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :get_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def show
    if User.find(params[:organization_id]).user_type === 'dev'
      redirect_to developer_path(params[:organization_id])
    # TODO: handle edge case for organizations that don't own the project
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.create(
      organization_id: params[:organization_id],
      description: project_params[:description],
      title: project_params[:title],
      time_frame: project_params[:time_frame],
      summary: project_params[:summary],
      contact_email: project_params[:contact_email]
      )
    if @project.valid?
      redirect_to organization_project_path(@project.organization, @project)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @project.update(organization_id: params[:organization_id],
                       description: project_params[:description],
                       title: project_params[:title],
                       time_frame: project_params[:time_frame],
                       summary: project_params[:summary],
                       contact_email: project_params[:contact_email]
                       )
      redirect_to organization_project_path(@project.organization, @project)
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path
  end


private
  def project_params
    params.require(:project).permit(:title, :description, :time_frame, :summary, :contact_email)
  end

  def redirect_if_incorrect_user
    if params[:organization_id].to_i != current_user.id
      return redirect_to organization_path(current_user)
    end
  end

  def get_project
    @project = Project.find(params[:id])
  end
end
