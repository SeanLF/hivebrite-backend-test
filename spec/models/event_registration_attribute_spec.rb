require 'rails_helper'

RSpec.describe EventRegistrationAttribute, type: :model do
  let(:permitted_data_types) { %w[string boolean].freeze }

  let(:event) { Event.create(name: 'event') }
  subject { described_class.create(event_id: event.id, name: 'Field', data_type: 'string') }

  describe 'Associations' do
    it { should belong_to(:event) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:event_id) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).ignoring_case_sensitivity }

    it { should validate_presence_of(:data_type) }
    it { should validate_inclusion_of(:data_type).in_array(permitted_data_types) }

    it { should have_db_index(:event_id) }
    # it { should have_db_index([:event_id, 'lower(name)']) }
  end
end
