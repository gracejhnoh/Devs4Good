class Project < ApplicationRecord
  validates_presence_of :title, :time_frame, :description

  has_many :proposals
  belongs_to :organization, class_name: 'User', foreign_key: 'organization_id'

end
