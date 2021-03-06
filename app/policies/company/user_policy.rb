class Company
  class UserPolicy < ApplicationPolicy
    def index?
      true
    end

    def show?
      true
    end

    def create?
      company_owner?
    end

    def update?
      company_owner? && user.id != record.id
    end

    def destroy?
      company_owner? && user.id != record.id
    end

    private

    def company_owner?
      user.company_owner?
    end

    class Scope < Scope
      def resolve
        scope.all
      end
    end
  end
end
