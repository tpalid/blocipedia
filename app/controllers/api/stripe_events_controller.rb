class Api::StripeEventsController < ApplicationController
   
    skip_before_action :verify_authenticity_token
    def router
        @event_json = JSON.parse(request.body.read)
        # @subscription = Subscription.find(customer_id: @event_json["customer"])
        @subscription = Subscription.find(user_id: 1)
        if @event_json["type"] == "customer.subscription.deleted"
            @subscription.delete
            #should this be in a separate method?
        elsif @event_json["type"] == "charge.succeeded"
            @subscription.update(current_period_end: event_json["data"]["current_period_end"])
        end
        redirect_to root_url
        #need to render something, or it will look for a template and find that there is no router template- find more logical thing to render!
    end
end