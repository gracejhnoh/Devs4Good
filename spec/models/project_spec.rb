require 'rails_helper'

describe Project do

  context 'validates' do
    it { is_expected.to validate_presence_of :description }

    it { is_expected.to validate_presence_of :title }

    it { is_expected.to validate_presence_of :time_frame }

    it { is_expected.to validate_presence_of :summary }
  end

end
