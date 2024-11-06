class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def create_checkout_session
    @event = Event.find(params[:event_id])

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'eur',
          product_data: {
            name: @event.title,
          },
          unit_amount: @event.price * 100, # Montant en centimes
        },
        quantity: 1,
      }],
      mode: 'payment',
      success_url: event_url(@event) + '?payment=success',
      cancel_url: event_url(@event) + '?payment=cancel',
    )

    redirect_to session.url, allow_other_host: true
  end
end
