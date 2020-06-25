class EventRegistrationAttribute < ApplicationRecord
  belongs_to :event
  has_many :event_registration_attribute_values

  PERMITTED_DATA_TYPES = %w[string boolean].freeze

  validates :event_id, presence: true
  validates :name, :data_type, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  validates :data_type, inclusion: { in: PERMITTED_DATA_TYPES }

  validates :required, inclusion: { in: [true, false] }

  scope :required, -> { where(required: true) }

  def required?
    required
  end
end
