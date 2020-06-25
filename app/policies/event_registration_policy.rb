class EventRegistrationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end

  def index?
    true
  end

  def new?
    true
  end

  def show?
    if user.admin?
      true
    else
      create?
    end
  end

  def create?
    user.id == record.user_id
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
