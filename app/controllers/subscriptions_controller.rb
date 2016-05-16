class SubscriptionsController < ApplicationController
  
  include SubscriptionsHelper

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Blocipedia Membership - #{current_user.name}",
      amount: Amount.default
    }
  end
  
  def show
    @subscription = Subscription.find_by_user_id(current_user.id)
    @private_wikis = Wiki.where(user_id: current_user.id).where(private: true)
  end
 
  def create
  # creates a Stripe Customer object, for associating with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken],
      plan: "blocipedia_subscription"
    )
    
    subscription = Subscription.create(
        user_id: current_user.id, 
        customer_id: customer.id,
        subscription_id: customer.subscriptions.data[0].id, 
        current_period_end: customer.subscriptions.data[0].current_period_end,
        status: "active"
        )
    
    flash[:notice] = "Your account has been upgraded!"
    redirect_to root_url
    
    # Rescue message for card errors
    rescue Stripe::CardError => e
    flash.now[:alert] = e.message
    redirect_to new_subscription_path
 
  end
  
  def edit
      @subscription = @subscription = Subscription.find_by_user_id(current_user) 
      @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Blocipedia Membership - #{current_user.name}",
      amount: Amount.default
    }
  end
    
  
  def update
    @subscription = Subscription.find_by_user_id(current_user.id)
    @customer = Stripe::Customer.retrieve(@subscription.customer_id)
    stripe_subscription = @customer.subscriptions.retrieve(@subscription.subscription_id)
    stripe_subscription.plan = "blocipedia_subscription"
    if stripe_subscription.save
      @subscription.update(status: "active")
      flash[:notice] = "Your subscription has been resumed!  Your private wikis will remain private, and your next payment will be due #{@subscription.period_end_date}"
      redirect_to subscription_path(@subscription)
    else
      flash[:notice] = "There was an error resuming your subscription. Please try again."
      redirect_to subscription_path(@subscription)
    end
      
  end
    
 
  def destroy
    subscription = Subscription.find_by_user_id(current_user.id)
    customer = Stripe::Customer.retrieve(subscription.customer_id)
    stripe_subscription = customer.subscriptions.retrieve(subscription.subscription_id).delete(at_period_end: true)
    subscription.update(status: "cancelled")
    

    flash[:notice] = "Your premium subscription has been cancelled.  Your account will be downgraded at the end of this payment period. At this time, all of your private wikis will be made public."
    redirect_to root_url
    
    # Rescue message for card errors
    rescue Stripe::InvalidRequestError
    flash[:alert] = "We were unable to delete your subscription. Please check that your subscription is currently active, and try again."
    redirect_to root_url
  end
  
end

