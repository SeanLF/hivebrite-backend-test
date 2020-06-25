require 'rails_helper'

RSpec.describe UserAttributeValuePolicy, type: :policy do
  let(:user) { User.find_or_create_by(username: '@me', password: '123') }
  let(:admin) { User.find_or_create_by(admin: true, username: '@admin', password: '123') }
  let(:user_attribute) { UserAttribute.find_or_create_by(name: 'attr', data_type: 'boolean') }
  let(:user_attribute_value) do
    UserAttributeValue.find_or_create_by(user_id: user.id, user_attribute_id: user_attribute.id, value: 'true')
  end
  let(:user_attribute_value2) do
    UserAttributeValue.find_or_create_by(user_id: admin.id, user_attribute_id: user_attribute.id, value: 'true')
  end

  let(:scope) { Pundit.policy_scope!(user, UserAttributeValue) }
  let(:admin_scope) { Pundit.policy_scope!(admin, UserAttributeValue) }

  subject { described_class }

  permissions '.scope' do
    it { expect(admin_scope.to_a).to match_array(UserAttributeValue.where(user_id: admin.id)) }
    it { expect(admin_scope.to_a).to_not include(UserAttributeValue.where(user_id: user.id).first) }
  end

  permissions :index?, :new? do
    it { should permit(user, UserAttributeValue.new) }
  end

  permissions :create? do
    it { should permit(user, user_attribute_value) }
    it { should_not permit(user, user_attribute_value2) }
  end

  permissions :show?, :update?, :edit?, :destroy? do
    it { should permit(user, user_attribute_value) }
    it { should permit(admin, user_attribute_value2) }

    it { should_not permit(admin, user_attribute_value) }
    it { should_not permit(user, user_attribute_value2) }
  end
end
