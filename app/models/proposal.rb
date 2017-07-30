class Proposal < ApplicationRecord
  belongs_to :project
  belongs_to :developer, class_name: 'User', foreign_key: :user_id

  validates_presence_of :user_id, :project_id, :description
end
