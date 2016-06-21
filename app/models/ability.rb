# Defines abilities of roles
#
# Documentation:
# https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    content_resources = [Expert, Quarter, ExpertSurvey, ReformSurvey, News, ExternalIndicator]

    if user.is? 'super_admin'
      can :manage, :all
    elsif user.is? 'site_admin'
      init_site_admin_abilities(content_resources)
      init_page_section
    elsif user.is? 'content_manager'
      can :manage, content_resources
      init_page_section
    end

    # Actions everyone can do:
    can :read, content_resources
  end

  def init_site_admin_abilities(content_resources)
    can :manage, content_resources
    can :manage, User
    can :manage, Role
    cannot :manage, User, role: { name: 'super_admin' }
    cannot :manage, Role, name: 'super_admin'
    can :read, ReformColor
    can :manage, Reform
  end

  def init_page_section
    can [:read, :edit, :update], PageContent
  end
end
