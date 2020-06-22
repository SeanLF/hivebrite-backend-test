class UserAttributeValue < ApplicationRecord
  belongs_to :user
  belongs_to :user_attribute

  validates :user_id, :user_attribute_id, :value, presence: true
  validates :user_attribute_id, uniqueness: { scope: :user_id }
end
