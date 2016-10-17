class CollaboratorPolicy < ApplicationPolicy
    
    alias_method :collaborator, :record
 
    def delete?
        collaborator.edit? && collaborator.creator? == false
    end
    
    private
        def wiki
            @wiki ||= Wiki.find(collaborator.wiki.id)
        end
    

end



