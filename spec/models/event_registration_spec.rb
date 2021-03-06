require 'rails_helper'

RSpec.describe EventRegistration, type: :model do
  describe 'Associations' do
    it { should have_many(:event_registration_attribute_values) }
  end

  let(:event) { Event.create(name: 'Event') }
  let(:user) { User.create(username: '@me', password: 'supersecure') }
  subject { described_class.new(event_id: event.id, user_id: user.id) }

  describe 'Associations' do
    it { should belong_to(:event) }
    it { should belong_to(:user) }

    it { should have_many(:event_registration_attribute_values) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:event) }
    it { should validate_presence_of(:user) }

    it { should validate_uniqueness_of(:user_id).scoped_to(:event_id) }

    it { should have_db_index(:event_id) }
    it { should have_db_index(:user_id) }
    it { should have_db_index(%i[user_id event_id]).unique }
  end
end
