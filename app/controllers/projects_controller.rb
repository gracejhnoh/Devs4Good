class ProjectsController < ApplicationController
  before_action :require_login, only: [:new]

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    if current_user.user_type == 'dev'
      redirect_to :root
    end
    @project = Project.new
  end

  def create
    @project = Project.create(
      organization_id: params[:organization_id],
      description: project_params[:description],
      title: project_params[:title],
      time_frame: project_params[:time_frame]
      )
    if @project.valid?
      redirect_to organization_project_path(@project, @project.organization)
    else
      render new_organization_project_path
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      redirect_to @project
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path
  end


private
  def project_params
    params.require(:project).permit(:title, :description, :time_frame)
  end
end
