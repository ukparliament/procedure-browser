class EventController < ApplicationController

  # We include modules required to get all steps and a step.
  include Sparql::Get::EventSteps
  include Sparql::Queries::EventSteps
  include Sparql::Get::Response

  def index
  end
  
  def show
    event_id = params[:event]
    @event_steps = get_event_steps( event_id )
    
    @event = Event.new
    @event.date = @event_steps.first.event_date
    @event.link = @event_steps.first.event_link
    
    if @event.date
      @page_title = "An event taking place on #{@event.date.strftime( $DATE_DISPLAY_FORMAT )}"
      #@description = "An event taking place on #{@event.date.strftime( $DATE_DISPLAY_FORMAT )}."
    else
      @page_title = "An event"
      #@description = "An event."
    end
    @crumb << { label: 'Event', url: nil }
    @section = 'work-packages'
  end
end
