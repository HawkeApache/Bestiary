class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.client?
      can :manage, Comment, user_id: user.id
      can :read, [Beast, Subject]
      cannot %i[update destroy create], [Subject, Beast]
      cannot :read, User
      can %i[update destroy], User, id: user.id
    elsif user.admin?
      can :manage, :all
    end
    can :create, User
  end
end

