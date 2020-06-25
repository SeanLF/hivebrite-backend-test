require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  let(:user) { User.find_or_create_by(username: '@me', password: '123') }
  let(:admin) { User.find_or_create_by(username: '@admin', admin: true, password: '123') }
  let(:scope) { Pundit.policy_scope!(user, User) }
  let(:admin_scope) { Pundit.policy_scope!(admin, User) }

  subject { described_class }

  permissions '.scope' do
    it { expect(admin_scope.to_a).to match_array(User.all) }
    it { expect(scope.to_a).to match_array([user]) }
  end

  permissions :index? do
    it { should permit(admin, user) }
    it { should_not permit(user, User.new) }
  end

  permissions :create?, :new? do
    it { should_not permit(admin, User.new) }
    it { should_not permit(user, User.new) }
  end

  permissions :show?, :update?, :edit?, :destroy? do
    it { should permit(admin, user) }
    it { should permit(admin, admin) }
    it { should permit(user, user) }
    it { should_not permit(user, User.new) }
  end
end
