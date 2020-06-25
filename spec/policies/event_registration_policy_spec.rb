require 'rails_helper'

RSpec.describe EventRegistrationPolicy, type: :policy do
  let(:user) { User.find_or_create_by(username: '@me', password: '123') }
  let(:admin) { User.find_or_create_by(admin: true, username: '@admin', password: '123') }
  let(:event) { Event.find_or_create_by(name: 'Event') }
  let(:event_registration_u) { EventRegistration.find_or_create_by(event_id: event.id, user_id: user.id) }
  let(:event_registration_a) { EventRegistration.find_or_create_by(event_id: event.id, user_id: admin.id) }

  let(:scope) { Pundit.policy_scope!(user, EventRegistration) }
  let(:admin_scope) { Pundit.policy_scope!(admin, EventRegistration) }

  subject { described_class }

  permissions '.scope' do
    context 'admin user' do
      it { expect(admin_scope.to_a).to match_array(EventRegistration.all) }
    end
    context 'regular user' do
      it { expect(scope.to_a).to match_array(EventRegistration.where(user_id: user.id)) }
      it { expect(scope.to_a).to_not include(event_registration_a) }
    end
  end

  permissions :index?, :new? do
    it { should permit(user, EventRegistration.new) }
  end

  permissions :create? do
    it { should permit(user, event_registration_u) }
    it { should_not permit(user, event_registration_a) }
  end

  permissions :show? do
    context 'admin user' do
      it { should permit(admin, event_registration_a) }
      it { should permit(admin, event_registration_u) }
    end
    context 'not admin user' do
      it { should permit(user, event_registration_u) }
      it { should_not permit(user, event_registration_a) }
    end
  end

  permissions :update?, :edit?, :destroy? do
    context 'admin user' do
      it { should permit(admin, event_registration_a) }
      it { should_not permit(admin, event_registration_u) }
    end
    context 'not admin user' do
      it { should permit(user, event_registration_u) }
      it { should_not permit(user, event_registration_a) }
    end
  end
end
