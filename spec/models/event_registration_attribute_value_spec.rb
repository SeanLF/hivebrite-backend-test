# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventRegistrationAttributeValue, type: :model do
  let(:permitted_data_types) { %w[string boolean] }

  let(:event) { Event.find_or_create_by(name: 'Event') }
  let(:user) { User.find_or_create_by(username: '@me', password: 'supersecure') }
  let(:event_registration) { EventRegistration.find_or_create_by(event_id: event.id, user_id: user.id) }
  let(:event_registration_attribute) do
    EventRegistrationAttribute.find_or_create_by(event_id: event.id, name: 'ToC read', data_type: 'boolean')
  end

  subject do
    described_class.find_or_create_by(
      event_registration_id: event_registration.id,
      event_registration_attribute_id: event_registration_attribute.id,
      value: 'true'
    )
  end

  describe 'Associations' do
    it { should belong_to(:event_registration) }
    it { should belong_to(:event_registration_attribute) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:event_registration_id) }
    it { should validate_presence_of(:event_registration_attribute_id) }
    it { should validate_presence_of(:value) }

    describe 'custom validation for value' do
      context 'data_type is a string' do
        it do
          event_registration_attribute.update(data_type: 'string')
          expect(subject.update(value: 'asdfasdf')).to eq(true)
        end
      end

      context 'data_type is a boolean' do
        it do
          event_registration_attribute.update(data_type: 'boolean')
          expect(subject.update(value: 'true')).to eq(true)
          expect(subject.update(value: 'false')).to eq(true)
        end

        it do
          event_registration_attribute.update(data_type: 'boolean')
          expect(subject.update(value: 12)).to_not eq(true)
          expect(subject.update(value: 'dfadsf')).to_not eq(true)
        end
      end
    end

    it { should validate_uniqueness_of(:event_registration_attribute_id).scoped_to(:event_registration_id) }

    it { should have_db_index(:event_registration_id) }
    it { should have_db_index(:event_registration_attribute_id) }
    it { should have_db_index(%i[event_registration_id event_registration_attribute_id]).unique }
  end
end
