class ProposalsController < ApplicationController
  def new
    @proposal = Proposal.new
    @project = Project.find(params[:project_id])
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
