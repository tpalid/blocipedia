class Api::StripeEventsController < ApplicationController
   
    skip_before_action :verify_authenticity_token
    def router
        @event_json = JSON.parse(request.body.read)
        if @event_json["type"] == "customer.subscription.deleted"
            @subscription = Subscription.where(customer_id: @event_json["data"]["object"]["customer"]).first
            #in case subscription doesn't exist
            if @subscription
               @subscription.destroy
            else
                404
            end
        elsif @event_json["type"] == "charge.succeeded"
            @subscription.update(current_period_end: event_json["data"]["current_period_end"])
        end
        puts "2"
        redirect_to root_url
        #need to render something, or it will look for a template and find that there is no router template- find more logical thing to render!
    end
    
  
end