class User < ActiveRecord::Base
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
         
  has_many :wikis
  after_initialize :set_default_role
  
   
  def upgrade_user(subscription)
    self.customer_id = subscription.customer_id
    self.subscription_id = subscription.subscription_id
    self.active_until = subscription.current_period_end
    self.role = "premium"
    self.save
  end
  
  def renew(active_until)
    self.active_until = active_until
    self.save
  end
  
  def downgrade
    self.active_until = nil
    self.role = "standard"
    self.save
  end
  
  def self.find_by_customer_id(customer_id)
    User.where(customer_id: customer_id)
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
