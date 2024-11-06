class AttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event

  def index
    @attendances = @event.attendances
  end

  def new
    @event = Event.find(params[:event_id])
    @attendance = Attendance.new#(event: @event)
  end

  def create
    @event = Event.find(params[:event_id])
    # @attendance = current_user.attendances.build(attendance_params.merge(event: @event))
    # @attendance = current_user.attendances.build(event: @event)
    @attendance = Attendance.new(user: current_user, event: @event)

    if @attendance.save
      redirect_to @event, notice: "Vous avez joint l'événement avec succès"
    else
      flash.now[:alert] = "Une putain d'erreur est survenue lors de l'inscription."
      render :new
    end
  end

  private

  def attendance_params
    params.require(:attendance).permit(:stripe_customer_id)
  end

  def set_event
    @event = Event.find(params[:event_id])
  end
end
