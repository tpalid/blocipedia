class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators
  after_initialize :set_default_privacy
  
  def set_default_privacy
    self.private ||= false
  end
  
  def public?
    self.private == false
  end
  
  def private?
    self.private == true
  end
  
 end
