class Collaborator < ActiveRecord::Base
    belongs_to :wiki
    belongs_to :user
    validates :wiki, presence: true
    validates :user, presence: true
    validates :wiki, uniqueness: { scope: :user }
    
    # def user_email
    #     user.try(:email)
    # end
    
    # def user_email=(user_email)
    #     self.user = User.find_by_email(:user_email) if user_email.present?
    # end
end
