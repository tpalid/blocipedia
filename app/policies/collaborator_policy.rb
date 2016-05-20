class CollaboratorPolicy < ApplicationPolicy
    
    alias_method :collaborator, :record

    def edit?
 
    end
    
    def destroy?
        collaborator.creator? == "false"
    end
    
    

end



