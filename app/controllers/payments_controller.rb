class PaymentsController < ApplicationController
  before_action :authenticate_user!

  # def create
  def create_checkout_session
    @total = params[:total].to_d
    @event_id = params[:event_id]
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [
        {
          price_data: {
            currency: 'eur',
            unit_amount: (@total*100).to_i,
            product_data: {
              name: 'Rails Stripe Checkout',
            },
          },
          quantity: 1
        },
      ],
      mode: 'payment',
      metadata: { event_id: @event_id },
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: checkout_cancel_url
    )
    redirect_to @session.url, allow_other_host: true
  end

  # def success
  #   @session = Stripe::Checkout::Session.retrieve(params[:session_id])
  #   @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
  #   @event_id = @session.metadata.event_id
    
  #   stripe_customer_id = "stripe_#{SecureRandom.hex(10)}" #Unique User ID
  #   Attendance.create(user: current_user, event_id: @event.id, stripe_customer_id: stripe_customer_id)
  #   redirect_to event_path(@event_id), notice: "Paiement réussi et participation enregistrée"
  # end


  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    @event = Event.find_by(id: @session.metadata.event_id)
  
    if @event
      stripe_customer_id = "stripe_#{SecureRandom.hex(10)}" # Unique User ID
      Attendance.create(user: current_user, event_id: @event.id, stripe_customer_id: stripe_customer_id)
      redirect_to event_path(@event), notice: "Paiement réussi et participation enregistrée"
    else
      redirect_to events_path, alert: "L'événement est introuvable"
    end
  end

  def cancel_url
    # redirect_to events_path, alert: "Echec paiement"
  end

end