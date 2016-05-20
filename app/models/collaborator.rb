class Collaborator < ActiveRecord::Base
    belongs_to :wiki
    belongs_to :user
    validates :wiki, presence: true
    validates :user, presence: true
    validates :user, uniqueness: { scope: :wiki }
    
    def creator?
        self.state == "creator"
    end
    
    def viewer?
        self.state == "view"
    end
    
    def editor?
        self.state == "edit"
    end
end
