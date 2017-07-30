class Project < ApplicationRecord
  validates_presence_of :title, :time_frame, :description

  has_many :proposals, dependent: :destroy
  belongs_to :organization, class_name: 'User', foreign_key: 'organization_id'

  def selected_proposal
    self.proposals.find_by(selected: true)
  end
end
