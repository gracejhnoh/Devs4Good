class ProposalsController < ApplicationController
  def new
    @proposal = Proposal.new
    @project = Project.find(params[:project_id])
  end

  def show
    @proposal = Proposal.find(params[:id])
  end

  def create
    @proposal = Proposal.create(project_id: params[:project_id], user_id: current_user.id, description: proposal_params[:description], selected: proposal_params[:selected])
    @project = Project.find(params[:project_id])
    if @proposal.valid?
      redirect_to organization_project_path(@project.organization, @project)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

private
  def proposal_params
    params.require(:proposal).permit(:description, :selected)
  end

end
