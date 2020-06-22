class EventRegistration < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :event_id, :user_id, presence: true
  validates :user_id, uniqueness: { scope: :event_id }
end
