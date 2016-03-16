class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :users, through: :collaborators
  
  def public?
    wiki.private == false
  end
  
  def private?
    wiki.private == true
  end
  
 end
