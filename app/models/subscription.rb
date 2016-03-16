class Subscription
   
  attr_accessor :customer_id, :user, :subscription_id, :current_period_end
  
  def initialize(user_id, customer_id, subsciption_id, current_period_end)
    @user_id = user_id
    @customer_id = customer_id
    @subscription_id = subscription_id
    @current_period_end = current_period_end
  end
  
  def upgrade_user
    @user = User.find_by(id: @user_id)
    puts @user
    @user.update(
      customer_id: @customer_id,
      subscription_id: @subscription_id,
      active_until: @current_period_end
    )
  end
    
    
  
  
  
end
    