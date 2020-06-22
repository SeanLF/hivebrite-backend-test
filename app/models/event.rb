require 'json'
class Event < ApplicationRecord
  has_many :event_registrations
  has_many :users, through: :event_registrations

  validates :name, presence: true
  validate :custom_attributes_valid

  private

  # keys are all non-empty strings or symbols
  def custom_attribute_keys_valid?
    custom_attributes.keys.all? { |key| (key.is_a?(String) && !key.strip.empty?) || key.is_a?(Symbol) }
  end

  # values are either a non-empty string or true or false
  def custom_attribute_values_valid?
    custom_attributes.values.all? do |value|
      (value.is_a?(String) && !value.strip.empty?) || [true, false].include?(value)
    end
  end

  def custom_attributes_valid
    valid = custom_attributes.nil?
    valid ||= custom_attributes.is_a?(Hash) && custom_attribute_keys_valid? && custom_attribute_values_valid?

    errors[:custom_attributes] << 'is not valid JSON' unless valid
  end
end
