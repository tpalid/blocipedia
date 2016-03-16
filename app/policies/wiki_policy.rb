class WikiPolicy < ApplicationPolicy
    
    attr_reader :user, :wiki
    
    def show?
        if wiki.public?
            user.present?
        elsif wiki.private?
            wiki.user == user || wiki.users.include?(user)
        end
    end
 
 
    class Scope
        attr_reader :user, :scope
        
        def initialize(user, scope)
            @user = user
            @scope = scope
        end
        
        def resolve
            wikis = []
            if user.role == 'admin'
                wikis = scope.all
            elsif user.role == 'premium'
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
end