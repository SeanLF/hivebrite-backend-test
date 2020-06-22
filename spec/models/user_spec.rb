require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.create(username: 'first', password: 'supersecure') }

  describe 'Associations' do
    it { should have_many(:event_registrations) }
    it { should have_many(:events).through(:event_registrations) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username).ignoring_case_sensitivity }

    it { should validate_presence_of(:password) }
  end
end
