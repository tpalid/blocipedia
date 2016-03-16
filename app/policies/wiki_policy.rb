class WikiPolicy < ApplicationPolicy
    
    attr_reader :user, :wiki
   
    def index?
        true
    end
    
    def show?
        if record.private? 
            record.user == user
            #current user isn't accessible from wiki_policy
        else
            true
        end
    end
    
    def update?
    end
    
    def edit?
        show?
    end
    
    def destroy?
        show?
    end
    
end