class User < ApplicationRecord
  has_many :event_registrations
  has_many :events, through: :event_registrations

  has_many :user_attributes
  has_many :user_attribute_values

  validates :username, :password, presence: true
  validates :username, uniqueness: { case_sensitive: false }
  validates :admin, inclusion: { in: [true, false] }

  validate :required_signup_attributes, on: :create
  validate :required_profile_attributes, on: :update

  scope :admin, -> { where(admin: true) }

  def admin?
    admin
  end

  private

  def required_signup_attributes
    errors[:base] << 'missing required signup attributes' unless all_required_signup_attributes_present?
  end

  def required_profile_attributes
    errors[:base] << 'missing required signup attributes' unless all_required_profile_attributes_present?
  end

  def all_required_signup_attributes_present?
    required_attribute_ids = UserAttribute.required_on_signup.pluck(:id)
    return true if required_attribute_ids.count.zero?

    user_attribute_ids = user_attribute_values.pluck(:user_attribute_id)
    required_attribute_ids.intersection(user_attribute_ids) == required_attribute_ids
  end

  def all_required_profile_attributes_present?
    required_attribute_ids = UserAttribute.required_on_profile.pluck(:id)
    return true if required_attribute_ids.count.zero?

    user_attribute_ids = user_attribute_values.pluck(:user_attribute_id)
    required_attribute_ids.intersection(user_attribute_ids) == required_attribute_ids
  end
end
