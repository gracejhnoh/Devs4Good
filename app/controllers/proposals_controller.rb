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
    @proposal = Proposal.find(params[:id])
    @project = Project.find(params[:project_id])
  end

  def update
    @proposal = Proposal.find(params[:id])
    if @proposal.update(proposal_params)
      if proposal_params[:selected] == 'true'
        redirect_to organization_project_path(@proposal.project, @proposal.project.organization)
      else
        redirect_to project_proposal_path(@proposal.project, @proposal)
      end
    else
      if proposal_params[:selected] == 'true'
        redirect_to organization_project_path(@proposal.project, @proposal.project.organization)
      else
        render :edit
      end
    end
  end

  def destroy
    @proposal = Proposal.find(params[:id])
    @proposal.destroy
    redirect_to organization_project_path(@proposal.project.organization_id, @proposal.project_id)
  end

private
  def proposal_params
    params.require(:proposal).permit(:description, :selected)
  end

end
