class StepEventController < ApplicationController

  # We include modules required to get a step and the work packages for a step.
  include Sparql::Get::Step
  include Sparql::Queries::Step
  include Sparql::Get::StepEvents
  include Sparql::Queries::StepEvents
  include Sparql::Get::Response

  def index
    step_id = params[:step]
    @step = get_step( step_id )
    @step_events = get_step_events( step_id )
    
    @page_title = "#{@step.label} - Events"
    @multiline_page_title = "#{@step.label} <span class='subhead'>Events</span>".html_safe
    @description = "Events for #{@step.label}."
    @rss_url = step_event_list_url( :format => 'rss' )
    @crumb << { label: 'Steps', url: step_type_list_url }
    @crumb << { label: @step.step_type_label, url: step_type_show_url( :step_type => @step.step_type_id ) }
    @crumb << { label: @step.label, url: step_show_url }
    @crumb << { label: 'Events', url: nil }
    @section = 'steps'
    @subsection = 'events'
  end
end
