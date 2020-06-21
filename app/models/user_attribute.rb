class UserAttribute < ApplicationRecord
  PERMITTED_DATA_TYPES = %w[string boolean].freeze
  validates :name, :data_type, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  validates :data_type, inclusion: { in: PERMITTED_DATA_TYPES }

  validates :required_on_signup, :required_on_profile, inclusion: { in: [true, false] }

  scope :required_on_signup, -> { where(required_on_signup: true) }
  scope :required_on_profile, -> { where(required_on_profile: true) }

  def required_on_signup?
    required_on_signup
  end

  def required_on_profile?
    required_on_signup
  end
end
