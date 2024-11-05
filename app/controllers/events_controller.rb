class EventsController < ApplicationController
  before_action :authenticate_user!
  
  def index
  end

  def show
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


end
