class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find params[:id]
  end

  def new
    @event = Event.new
  end

  def create
    event_params = params.require(:event).permit(:title, :description, :date)
    @event = Event.new event_params
    @event.user = current_user
    if @event.save
      redirect_to event_path(@event)
    else
      render :new
    end
  end

  def edit
    @event = current_user.events.find params[:id]
  end

  def update
    event_params = params.require(:event).permit(:title, :description, :date)
    @event = current_user.events.find params[:id]
    if @event.update event_params
      redirect_to event_path(@event)
    else
      render :edit
    end
  end

  def destroy
    event = current_user.events.find params[:id]
    event.destroy
    redirect_to events_path
  end
end
