class Api::V1::ChargesController < Api::ApplicationController
  before_action :authenticate_user!

  def create
    begin

      selector = Stripe::Customer.list(email: current_user.email)['data'][0]
      if selector
        @customer = Stripe::Customer.retrieve(selector.id)
      else
        @customer = Stripe::Customer.create(
          :name => current_user.full_name,
          :email => current_user.email,
          :source => params[:charge][:token]
        )
      end

      subscription = Stripe::Subscription.create({
        :customer => @customer.id,
        :items => [
          {
            plan: 'plan_FhG2ysrZwS7y3Z'
          },
        ]
      });
      current_user.update({is_pro: true})

      render(json: {subscription: subscription.id, customer: @customer.id}, status: 200)
    rescue Stripe::CardError => e 
      render(json: {error: e}, status: 422)
    end
  end
end
