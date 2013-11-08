class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

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
      can :create, Advert
      can :manage, [Advert, Comment], :user_id => user.id
    else
      can :read, :all
    end
  end
end
