class UserAttributePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user.admin? ? scope.all : scope.none
    end
  end

  def index?
    user.admin?
  end

  def create?
    user.admin?
  end
end
