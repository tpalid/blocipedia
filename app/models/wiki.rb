class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators
  
  def public?
    self.private == false
  end
  
  def private?
    self.private == true
  end
  
 end
