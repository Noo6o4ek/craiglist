class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new(role_id: 3) # guest user (not logged in)

    can [:edit, :update, :destroy], User do |u|
      u.id == user.id
    end

    case user.role_name
    when 'admin'
      can :manage, :all
    when 'moderator'
      can :read, :all
    else
      can :read, :all
    end
  end
end
