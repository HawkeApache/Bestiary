class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.client?
      can :manage, :all
      cannot [:update, :destroy, :create], [Subject, Beast]
    elsif user.admin?
      can :manage
    end
  else
    can :create, User
  end
end

