require 'rails_helper'

RSpec.describe EventPolicy, type: :policy do
  let(:user) { User.new }
  let(:scope) { Pundit.policy_scope!(user, Event) }

  subject { described_class }

  permissions '.scope' do
    it { expect(scope).to eq(Event.all) }
  end

  permissions :index?, :show? do
    it 'grants permission' do
      should permit(User.new, Event.new)
    end
  end

  permissions :create?, :new?, :update?, :edit?, :destroy? do
    it 'grants access if user is an admin' do
      expect(subject).to permit(User.new(admin: true), Event.new)
    end

    it 'denies access if user is not an admin' do
      expect(subject).not_to permit(User.new, Event.new)
    end
  end
end
