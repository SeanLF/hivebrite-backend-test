require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:name) }

    it 'should permit valid JSON in custom attributes' do
      expect(Event.new(name: 'name').valid?).to eq(true)
      expect(Event.new(name: 'name', custom_attributes: {}).valid?).to eq(true)
      expect(Event.new(name: 'name', custom_attributes: { name: 'bob' }).valid?).to eq(true)
      expect(Event.new(name: 'name', custom_attributes: { name: 'bob', 'another' => '2' }).valid?).to eq(true)
    end

    it 'should disallow invalid JSON in custom attributes' do
      expect(Event.new(name: 'name', custom_attributes: []).valid?).to eq(false)
      expect(Event.new(name: 'name', custom_attributes: { name: '' }).valid?).to eq(false)
      expect(Event.new(name: 'name', custom_attributes: { name: '  ' }).valid?).to eq(false)
      expect(Event.new(name: 'name', custom_attributes: { name: 'bob', 'another' => 2 }).valid?).to eq(false)
      expect(Event.new(name: 'name', custom_attributes: { 1 => 2 }).valid?).to eq(false)
      expect(Event.new(name: 'name', custom_attributes: { [] => 2 }).valid?).to eq(false)
      expect(Event.new(name: 'name', custom_attributes: { {} => 2 }).valid?).to eq(false)
      expect(Event.new(name: 'name', custom_attributes: { true => 2 }).valid?).to eq(false)
      expect(Event.new(name: 'name', custom_attributes: { nil => 2 }).valid?).to eq(false)
      expect(Event.new(name: 'name', custom_attributes: { nil => 2 }).valid?).to eq(false)
      expect(Event.new(name: 'name', custom_attributes: { name: nil, 'another' => '2' }).valid?).to eq(false)
    end
  end

  describe 'Associations' do
    it { should have_many(:event_registrations) }
    it { should have_many(:users).through(:event_registrations) }
  end
end
