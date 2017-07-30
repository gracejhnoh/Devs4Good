class ProjectsController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]

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
    if params[:organization_id].to_i != current_user.id
      redirect_to organization_path(current_user)
    else
      if current_user.user_type == 'dev'
        redirect_to :root
      end
      @project = Project.new
    end
  end

  def create
    if params[:organization_id].to_i != current_user.id
      redirect_to organization_path(current_user)
    else
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
  end

  def edit
    if params[:organization_id].to_i != current_user.id
      redirect_to organization_path(current_user)
    else
      @project = Project.find(params[:id])
    end
  end

  def update
    if params[:organization_id].to_i != current_user.id
      redirect_to organization_path(current_user)
    else
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
  end

  def destroy
    if params[:organization_id].to_i != current_user.id
      redirect_to organization_path(current_user)
    else
      @project = Project.find(params[:id])
      @project.destroy
      redirect_to projects_path
    end
  end


private
  def project_params
    params.require(:project).permit(:title, :description, :time_frame)
  end
end
