class SubscriptionsController < ApplicationController

include SubscriptionsHelper


  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Blocipedia Membership - #{current_user.name}",
      amount: Amount.default
    }
  end
 
  def create
  # creates a Stripe Customer object, for associating with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken],
      plan: "blocipedia_subscription"
    )
    
    current_user.upgrade(
      customer.id,
      customer.subscriptions.data[0].id, 
      customer.subscriptions.data[0].current_period_end
        )
   
    flash[:notice] = "Your account has been upgraded!"
    redirect_to root_url
    
    # Rescue message for card errors
    rescue Stripe::CardError => e
    flash.now[:alert] = e.message
    redirect_to new_subscription_path
 
  end
  
  def update
    200
  end
    
    
  
  def destroy
    customer = Stripe::Customer.retrieve(current_user.customer_id)
    subscription = customer.subscriptions.retrieve(current_user.subscription_id)
    subscription.delete
    #todo set customer.subscriptions.retrieve(current_user.subscription_id).delete(at_period_end: true)
    #set up webhooks, so that downgrade happens when I recieve the info that the subscription has been cancelled
    current_user.downgrade
    #subscription is being deleted on stripe, but I'm getting an error, example: "Customer cus_83Jks51BpKLhYa does not have a subscription with ID sub_83JkuPx2vPc56w"
    flash[:notice] = "Your premium subscription has been cancelled."
    redirect_to root_url
    
    # Rescue message for card errors
    rescue Stripe::InvalidRequestError
    flash[:alert] = "We were unable to delete your subscription. Please check that your subscription is currently active, and try again."
    redirect_to root_url
  end
  
end

