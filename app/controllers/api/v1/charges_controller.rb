class Api::V1::ChargesController < Api::ApplicationController
  def create
    begin
      customer = Stripe::Customer.create(
        :email => current_user.email,
        :source => params[:charge][:token]
      )
      charge = Stripe::Charge.create({
        :customer => customer.id,
        :amount => 100,
        :currency => 'cad',
        :description => params[:charge][:description]
      })
    rescue Stripe::CardError => e 
      render(json: {error: e}, status: 422)
    end
  end
end
