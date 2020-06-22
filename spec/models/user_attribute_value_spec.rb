require 'rails_helper'

RSpec.describe UserAttributeValue, type: :model do
  let(:user) { User.create(username: '@me', password: 'supersecure') }
  let(:user_attribute) { UserAttribute.create(name: 'attribute', data_type: 'boolean') }
  subject do
    described_class.new(user_id: user.id, user_attribute_id: user_attribute.id, value: 'true')
  end

  describe 'Validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:user_attribute_id) }

    it { should validate_uniqueness_of(:user_attribute_id).scoped_to(:user_id) }

    it { should validate_presence_of(:value) }

    it { should have_db_index(:user_id) }
    it { should have_db_index(:user_attribute_id) }
    it { should have_db_index(%i[user_id user_attribute_id]).unique }
  end
end
