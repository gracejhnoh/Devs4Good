class ProjectsController < ApplicationController
  before_action :require_login, only: [:new]

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])

    if User.find(params[:organization_id]).user_type === 'dev'
      redirect_to developer_path(params[:organization_id])
    # todo post-MVP: handle edge case for organizations that don't own the project
    end
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
      redirect_to organization_project_path(@project.organization, @project)
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(
      organization_id: params[:organization_id],
      description: project_params[:description],
      title: project_params[:title],
      time_frame: project_params[:time_frame]
      )
      redirect_to organization_project_path(@project.organization, @project)
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
