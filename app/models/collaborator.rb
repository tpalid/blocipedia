class Collaborator < ActiveRecord::Base
    belongs_to :wiki
    belongs_to :user
    validates :wiki, presence: true
    validates :user, presence: true
    validates :wiki, uniqueness: { scope: :user }
end
