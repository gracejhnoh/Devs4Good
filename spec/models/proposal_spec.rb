require 'rails_helper'

describe Proposal do
  context 'validations' do
    it { is_expected.to validate_presence_of :user_id }

    it { is_expected.to validate_presence_of :project_id }

    it { is_expected.to validate_presence_of :description }
  end
end
