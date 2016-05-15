class CollaboratorPolicy < ApplicationPolicy
    
    alias_method :collaborator, :record
    
    # def edit?
    #     wiki.user == user || user.admin?
    # end

end



