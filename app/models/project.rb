class Project < ApplicationRecord
  validates_presence_of :title, :time_frame, :description, :summary
  validates :summary, length: {maximum: 255}
  validates :title, length: {maximum: 50}

  has_many :proposals, dependent: :destroy
  belongs_to :organization, class_name: 'User', foreign_key: 'organization_id'

  def selected_proposal
    self.proposals.find_by(selected: true)
  end

  def developer_proposals(id)
    self.proposals.where(user_id: id)
  end
end
