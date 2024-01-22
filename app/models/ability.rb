class Ability
    include CanCan::Ability
  
    def initialize(user)
      if user.role?(:Admin)
      can :create, :all
      end
    end
    
  end
  