class EventRegistrationAttributeValuePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.includes(:event_registration).where(event_registrations: { user_id: user.id })
      end
    end
  end

  def index?
    true
  end

  def new?
    true
  end

  def create?
    record.event_registration.user_id == user.id
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
