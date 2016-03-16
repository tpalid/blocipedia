class User < ActiveRecord::Base
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
         
  has_many :wikis
  has_one :subscription
  has_many :wikis, through: :collaborators
  after_initialize :set_default_role
  
   
  def renew(active_until)
    self.active_until = active_until
    self.save
  end
  
  def set_default_role
    self.role ||= "standard"
  end
  
  def standard?
    role == "standard"
  end
  
  def premium?
    role == "premium"
  end
  
  def admin?
    role == "admin"
  end
end
