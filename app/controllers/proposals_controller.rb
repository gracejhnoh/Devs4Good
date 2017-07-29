class ProposalsController < ApplicationController
  def new
    @proposal = Proposal.new
    @project = Project.find(params[:project_id])
  end

  def create
    @proposal = Proposal.create(project_id: params[:project_id], user_id: current_user.id, description: params[:description], selected?: params[:selected?])
    @project = Project.find(params[:project_id])
    if @proposal.save!
      redirect_to project_proposals_path
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

end
