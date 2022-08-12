module Roleable
    extend ActiveSupport::Concern
    included do
        # The list of roles
        ROLES = [:admin, :manager, :player]
        
        
        #json column will store the roles
        store_accessor :roles, *ROLES
        
        #Cast the roles to and from booleans
        ROLES.each do |role|
            scope role, -> { where("roles @> ?" , {role => true}.to_json) }
            define_method(:"#{role}=") { |value| super ActiveRecord::Type::Boolean.new.cast(value) }
            define_method(:"#{role}?") { send(role) }
    end
    
    def active_roles #Wherever the value = True
    ROLES.select { |role| send(:"#{role}?") }.compact
    end

#The role validation
    validate :must_have_a_role, on: :update
    validate :must_have_an_admin
    
    private
    
    def must_have_an_admin
     if persisted? &&
         (User.where.not(id: id).pluck(:roles).count { |h| h["admin"] == true } < 1) &&
         roles_changed? && admin == false
        errors.add(:base, "There has to be 1 admin")
     
     end
    end
    
    def must_have_a_role
     if roles.values.none?
        errors.add(:base, "The user must have a role")
     end
    end
end 
end 

