class UserAttributeValuePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user_id: user.id)
    end
  end

  def index?
    true
  end

  def new?
    true
  end

  def create?
    record.user_id == user.id
  end
end
