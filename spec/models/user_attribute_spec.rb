require 'rails_helper'

RSpec.describe UserAttribute, type: :model do
  let(:permitted_data_types) { %w[string boolean].freeze }
  subject { described_class.create(name: 'Field', data_type: 'string') }

  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).ignoring_case_sensitivity }

    it { should validate_presence_of(:data_type) }
    it { should validate_inclusion_of(:data_type).in_array(permitted_data_types) }

    it { should have_db_index('lower(name)').unique }
  end
end
