class Api::StripeEventsController < ApplicationController
   
    skip_before_action :verify_authenticity_token
    def router
        event_json = JSON.parse(request.body.read)
        @user = User.find_by_customer_id(event_json["customer"])
        if event_json["type"] == "customer.subscription.deleted"
            @user.downgrade
            #how do i route this to the right model?
        elsif event_json["type"] == "charge.succeeded"
            @user.renew(event_json["data"]["current_period_end"])
        end
        redirect_to root_url
        #need to render something, or it will look for a template and find that there is no router template- find more logical thing to render!
    end
end