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
      can :manage, Advert
      can :manage, Comment
    when 'user'
      can :read, :all
      can :manage, Advert do |item|
        item.user_id == user.id
      end if user.id?
      can :manage, Comment do |item|
        item.user_id == user.id
      end if user.id?
    else
      can :read, :all
    end
  end
end
