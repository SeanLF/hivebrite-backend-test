class User < ApplicationRecord
  validates :username, :password, presence: true
  validates :username, uniqueness: { case_sensitive: false }
  validates :admin, inclusion: { in: [true, false] }

  scope :admin, -> { where(admin: true) }

  def admin?
    admin
  end
end
