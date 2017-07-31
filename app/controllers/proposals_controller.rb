class ProposalsController < ApplicationController
  before_action :require_login

  def new
    if current_user.user_type == 'org'
      redirect_to organization_path(current_user)
    else
      @proposal = Proposal.new
      @project = Project.find(params[:project_id])
    end
  end

  def show
    @proposal = Proposal.find(params[:id])
    if current_user != @proposal.developer && current_user != @proposal.project.organization
      redirect_to organization_project_path(@proposal.project.organization, @proposal.project)
    end
  end

  def create
    if current_user.user_type == 'org'
      redirect_to organization_path(current_user)
    else
      @proposal = Proposal.create(project_id: params[:project_id], user_id: current_user.id, description: proposal_params[:description], selected: proposal_params[:selected])
      @project = Project.find(params[:project_id])
      if @proposal.valid?
        UserMailer.new_proposal_email(@project.organization, @proposal).deliver_now
        redirect_to project_proposal_path(@project, @proposal)
      else
        render :new
      end
    end
  end

  def edit
    @proposal = Proposal.find(params[:id])
    @project = Project.find(params[:project_id])
    if current_user != @proposal.developer
      redirect_to organization_path(current_user)
    end
  end

  def update
    @proposal = Proposal.find(params[:id])
    if proposal_params[:selected] == 'true'
      if current_user != @proposal.project.organization
        redirect_to organization_path(@proposal.project.organization)
      else
        if @proposal.update(proposal_params)
          UserMailer.proposal_selected_email(@proposal.developer, @proposal).deliver_now
          redirect_to organization_project_path(@proposal.project.organization, @proposal.project)
        else
          redirect_to project_proposal_path(@proposal.project, @proposal)
        end
      end
    else
      if current_user != @proposal.developer
        redirect_to organization_path(@proposal.project.organization)
      else
        if @proposal.update(proposal_params)
          redirect_to project_proposal_path(@proposal.project, @proposal)
        else
          render :edit
        end
      end
    end
  end

  def destroy
    @proposal = Proposal.find(params[:id])
      if current_user != @proposal.developer
        redirect_to organization_path(current_user)
      else
        @proposal.destroy
        redirect_to organization_project_path(@proposal.project.organization_id, @proposal.project_id)
      end
  end

private
  def proposal_params
    params.require(:proposal).permit(:description, :selected)
  end
end
