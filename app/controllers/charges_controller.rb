class ChargesController < ApplicationController

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Membership - #{current_user.name}",
      amount: 10_00
    }
  end

#creates a new charge. Can i shove the user role update at the bottom of this?
  def create
    @amount = 10_00

    #creating Stripe customer object for unique charge
    customer = Stripe::Customer.create(
    email: current_user.email,
    card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: "Premium Membership - #{current_user.email}",
      currency: 'usd'
    )

    current_user.update_attributes!( role: 'premium' )

    flash[:success] = "Thank you for your payment, #{current_user.email}!"
    redirect_to welcome_index_path

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

end
