# spec/models/gym_spec.rb

require 'rails_helper'

RSpec.describe Gym, type: :model do
  subject { create(:gym) }

  context 'validations' do
    subject { create(:gym) }

    %i[name document_number document_type email].each do |attr|
      it { is_expected.to validate_presence_of(attr) }
    end
  end
end
