# event_registration_attribute_id
# event_registration_id
require 'rails_helper'

RSpec.describe EventRegistrationAttributeValuePolicy, type: :policy do
  # Users
  let(:user) { User.find_or_create_by(username: '@me', password: '123') }
  let(:admin) { User.find_or_create_by(admin: true, username: '@admin', password: '123') }

  # Event
  let(:event) { Event.find_or_create_by(name: 'Event') }

  # Event Registration
  let(:event_registration_u) { EventRegistration.find_or_create_by(event_id: event.id, user_id: user.id) }
  let(:event_registration_a) { EventRegistration.find_or_create_by(event_id: event.id, user_id: admin.id) }

  # Event Registration attribute
  let(:event_registration_attribute) do
    EventRegistrationAttribute.find_or_create_by(
      event_id: event.id,
      name: 'attr',
      data_type: 'boolean'
    )
  end

  # Event Registration attribute values
  let(:event_registration_attribute_value_u) do
    EventRegistrationAttributeValue.find_or_create_by(
      event_registration_id: event_registration_u.id,
      event_registration_attribute_id: event_registration_attribute.id,
      value: 'true'
    )
  end
  let(:event_registration_attribute_value_a) do
    EventRegistrationAttributeValue.find_or_create_by(
      event_registration_id: event_registration_a.id,
      event_registration_attribute_id: event_registration_attribute.id,
      value: 'true'
    )
  end

  # Scopes
  let(:scope) { Pundit.policy_scope!(user, EventRegistrationAttributeValue) }
  let(:admin_scope) { Pundit.policy_scope!(admin, EventRegistrationAttributeValue) }

  subject { described_class }

  permissions '.scope' do
    it { expect(admin_scope).to include(event_registration_attribute_value_a) }
    it { expect(admin_scope).to include(event_registration_attribute_value_u) }
  end

  permissions :index?, :new? do
    it { should permit(user, EventRegistrationAttributeValue.new) }
  end

  permissions :create? do
    context 'user is admin' do
      it { should permit(admin, event_registration_attribute_value_a) }
      it { should_not permit(admin, event_registration_attribute_value_u) }
    end

    context 'user is not admin' do
      it { should permit(user, event_registration_attribute_value_u) }
      it { should_not permit(user, event_registration_attribute_value_a) }
    end
  end

  permissions :show? do
    context 'user is admin' do
      it { should permit(admin, event_registration_attribute_value_a) }
      it { should permit(admin, event_registration_attribute_value_u) }
    end

    context 'user is not admin' do
      it { should permit(user, event_registration_attribute_value_u) }
      it { should_not permit(user, event_registration_attribute_value_a) }
    end
  end

  permissions :update?, :edit?, :destroy? do
    context 'user is admin' do
      it { should permit(admin, event_registration_attribute_value_a) }
      it { should_not permit(admin, event_registration_attribute_value_u) }
    end

    context 'user is not admin' do
      it { should permit(user, event_registration_attribute_value_u) }
      it { should_not permit(user, event_registration_attribute_value_a) }
    end
  end
end
