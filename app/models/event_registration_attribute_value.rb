class EventRegistrationAttributeValue < ApplicationRecord
  belongs_to :event_registration
  belongs_to :event_registration_attribute

  validates :event_registration_id, :event_registration_attribute_id, :value, presence: true
  validate :value_of_proper_data_type

  validates :event_registration_attribute_id, uniqueness: { scope: :event_registration_id }

  def value_of_proper_data_type
    if event_registration_attribute.nil?
      errors[:event_registration_attribute_id] << 'should not be null'
      return
    end

    expected_data_type = event_registration_attribute.data_type
    if expected_data_type == 'boolean'
      errors[:value] << "is not a #{expected_data_type}" unless [true, false].map(&:to_s).include?(value)
    elsif expected_data_type == 'string'
      errors[:value] << "is not a #{expected_data_type}" unless value.is_a?(String)
    end
  end
end
