class ChargesController < ApplicationController

include ChargesHelper
 
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
      card: params[:stripeToken]
    )
  
    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: Amount.default, #need to create amount class
      description: "Blocipedia Membership - #{current_user.email}",
      currency: "usd"
    )
  
    current_user.upgrade
    puts current_user.role
    flash[:notice] = "Your account has been upgraded!"
    redirect_to root_url
    
    # Rescue message for card errors
    rescue Stripe::CardError => e
    flash.now[:alert] = e.message
    redirect_to new_charge_path
 
  end

 end

