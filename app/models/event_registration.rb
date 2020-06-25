class EventRegistration < ApplicationRecord
  belongs_to :event
  belongs_to :user

  has_many :event_registration_attributes
  has_many :event_registration_attribute_values

  validates :event, :user, presence: true
  validates :user_id, uniqueness: { scope: :event_id }

  validate :required_attributes

  private

  def required_attributes
    errors[:base] << 'missing required attributes' unless all_required_attributes_present?
  end

  def all_required_attributes_present?
    required_attribute_ids = event_registration_attributes.required.pluck(:id)
    return true if required_attribute_ids.count.zero?

    event_registration_attributes_value_ids = event_registration_attribute_values.pluck(:event_registration_attribute_id)
    required_attribute_ids.intersection(event_registration_attributes_value_ids) == required_attribute_ids
  end
end
