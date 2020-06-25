require 'rails_helper'

RSpec.describe EventRegistrationAttributePolicy, type: :policy do
  let(:user) { User.new }
  let(:admin) { User.new(admin: true) }
  let(:event) { Event.find_or_create_by(name: 'Event') }
  let(:event_registration_attribute) do
    EventRegistrationAttribute.find_or_create_by(event_id: event.id, name: 'attr', data_type: 'boolean')
  end

  let(:scope) { Pundit.policy_scope!(user, EventRegistrationAttribute) }
  let(:admin_scope) { Pundit.policy_scope!(admin, EventRegistrationAttribute) }

  subject { described_class }

  permissions '.scope' do
    context 'user is admin' do
      it { expect(admin_scope.to_a).to match_array(EventRegistrationAttribute.all) }
    end
    context 'user is not admin' do
      it { expect(scope.to_a).to match_array([]) }
    end
  end

  permissions :show?, :create?, :new?, :update?, :edit?, :destroy? do
    context 'user is admin' do
      it { should permit(admin, event_registration_attribute) }
    end
    context 'user is not admin' do
      it { should_not permit(user, event_registration_attribute) }
    end
  end
end
