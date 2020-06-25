require 'rails_helper'

RSpec.describe UserAttributePolicy, type: :policy do
  let(:user) { User.new }
  let(:admin) { User.new(admin: true) }
  let(:user_attribute) { UserAttribute.find_or_create_by(name: 'attr', data_type: 'boolean') }

  let(:scope) { Pundit.policy_scope!(user, UserAttribute) }
  let(:admin_scope) { Pundit.policy_scope!(admin, UserAttribute) }

  subject { described_class }

  permissions '.scope' do
    context 'user is admin' do
      it { expect(admin_scope.to_a).to match_array(UserAttribute.all) }
    end
    context 'user is not admin' do
      it { expect(scope.to_a).to match_array([]) }
    end
  end

  permissions :show?, :create?, :new?, :update?, :edit?, :destroy? do
    context 'user is admin' do
      it { should permit(admin, user_attribute) }
    end
    context 'user is not admin' do
      it { should_not permit(user, user_attribute) }
    end
  end
end
