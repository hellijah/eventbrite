class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_event_creator!
  before_action :set_event
  
  def index
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    @event.start_date = DateTime.new(
      params[:event]["start_date(1i)"].to_i,
      params[:event]["start_date(2i)"].to_i,
      params[:event]["start_date(3i)"].to_i,
      params[:event]["start_date(4i)"].to_i,
      params[:event]["start_date(5i)"].to_i
    )
    if @event.save
      redirect_to @event, notice: 'Evenement créée'
    else
      # render :new, alert: 'erreur création evenement'
      puts @event.errors.full_messages # this will print validation errors to the server log
      render :new
    end
  end

  def attendances
    @event = Event.find(params[:id])
    @attendances = @event.attendances.includes(:user)
  end

  def set_event
    @event = Event.find(params[:id])
  end
private

def event_params
  params.require(:event).permit(:title, :description, :location, :start_date, :duration, :price)
end

# def event_params
#   params.require(:event).permit(:title, :description, :location, :duration, :price).merge(
#     start_date: DateTime.new(
#       params[:event]["start_date(1i)"].to_i,
#       params[:event]["start_date(2i)"].to_i,
#       params[:event]["start_date(3i)"].to_i,
#       params[:event]["start_date(4i)"].to_i,
#       params[:event]["start_date(5i)"].to_i
#     )
#   )
# end

def authorize_event_creator!
  @event = Event.find(params[:id])
  redirect_to root_path, alert: "Vous n'êtes pas autorisé à accéder à cette page" unless current_user == @event.user
end

end
