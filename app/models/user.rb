class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
         
  has_many :wikis
  after_initialize :set_default_role
  
  def set_default_role
    self.role ||= "standard"
  end
  
  def upgrade(customer_id, subscription_id, current_period_end)
    self.customer_id = customer_id
    self.subscription_id = subscription_id
    self.active_until = current_period_end
    # self.role = "premium"
    self.save
  end
  
  def downgrade
    self.active_until = 0
    self.role = "standard"
    self.save
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
