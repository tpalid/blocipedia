class WikiPolicy < ApplicationPolicy
    
    alias_method :wiki, :record
   
     def show?
        if wiki.public?
             user.present?
        elsif wiki.private?
             wiki.user == user || wiki.users.include?(user) || user.admin?
        end
     end
     
     def edit?
         if wiki.public?
             user.present?
         elsif wiki.private?
            wiki.user == user || user.admin? || collaborator.state == "edit"
         end
     end
    
    def destroy?
         wiki.user == user || user.admin?
    end
 
     class Scope < Scope
        
        def resolve
            wikis = []
            if user && user.admin?
                wikis = scope.all
            elsif user && user.premium?
                all_wikis = scope.all
                all_wikis.each do |wiki|
                    if wiki.public? || wiki.user == user || wiki.users.include?(user)
                        wikis << wiki
                    end
                end
            else
                all_wikis = scope.all
                all_wikis.each do |wiki|
                    if wiki.public? || wiki.users.include?(user)
                        wikis << wiki
                    end
                end
            end
            wikis
        end
     end
    
private
    def collaborator
	    @collaborator ||= Collaborator.find_by(user_id: user.id, wiki_id: record.id)
    end
end