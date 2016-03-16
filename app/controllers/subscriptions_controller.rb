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
    
    subscription = Subscription.create(current_user.id, customer.id, customer.subscriptions.data[0].id, customer.subscriptions.data[0].current_period_end)
    
    flash[:notice] = "Your account has been upgraded!"
    redirect_to root_url
    
    # Rescue message for card errors
    rescue Stripe::CardError => e
    flash.now[:alert] = e.message
    redirect_to new_subscription_path
 
  end
  
  def destroy
    customer = Stripe::Customer.retrieve(current_user.customer_id)
    subscription = customer.subscriptions.retrieve(current_user.subscription_id).delete(at_period_end: true)

    flash[:notice] = "Your premium subscription has been cancelled.  Your account will be downgraded at the end of this payment period. At this time, all of your private wikis will be made public."
    redirect_to root_url
    
    # Rescue message for card errors
    rescue Stripe::InvalidRequestError
    flash[:alert] = "We were unable to delete your subscription. Please check that your subscription is currently active, and try again."
    redirect_to root_url
  end
  
end

