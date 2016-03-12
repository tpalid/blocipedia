class Subscription
  
  def upgrade(customer_id, subscription_id, current_period_end)
    current_user.customer_id = customer_id
    current_user.subscription_id = subscription_id
    current_user.active_until = current_period_end
    # current_user.role = "premium"
    current_user.save
  end
  
  def renew(active_until)
    self.active_until = active_until
    self.save
  end
  
  def downgrade
    user.active_until = nil
    user.role = "standard"
    user.save
  end
  
  def self.find_by_customer_id(customer_id)
    User.where(customer_id = customer_id)
  end

end
    