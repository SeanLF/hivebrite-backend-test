class User < ApplicationRecord
  has_many :event_registrations
  has_many :events, through: :event_registrations

  validates :username, :password, presence: true
  validates :username, uniqueness: { case_sensitive: false }
  validates :admin, inclusion: { in: [true, false] }

  scope :admin, -> { where(admin: true) }

  def admin?
    admin
  end
end
