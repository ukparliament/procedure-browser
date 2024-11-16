class WorkPackageEventController < ApplicationController

  # We include modules required to get a work package.
  include Sparql::Get::WorkPackage
  include Sparql::Queries::WorkPackage
  include Sparql::Get::WorkPackageEvents
  include Sparql::Queries::WorkPackageEvents
  include Sparql::Get::Response
  include Timeline::Timeline

  def index
    work_package_id = params[:work_package]
  
    # We get the work package.
    @work_package = get_work_package( work_package_id )
  
    # We get all the events for the work package.
    @work_package_events = get_work_package_events( work_package_id )
  
    # We get arrays of pertinent past events, future events and undated events.
    @work_package_pertinent_past_events = get_pertinent_events_of_type( @work_package_events, 'past' )
    @work_package_pertinent_future_events = get_pertinent_events_of_type( @work_package_events, 'future' )
    @work_package_pertinent_undated_events = get_pertinent_events_of_type( @work_package_events, 'undated' )
  
    # We construct arrays of past events, future events and undated events structured for display as nested lists.
    # These are an array of days containing an array of events, containing an array of steps.
    @work_package_past_events = construct_events_array_for_work_package( @work_package_pertinent_past_events )
    @work_package_future_events = construct_events_array_for_work_package( @work_package_pertinent_future_events )
    @work_package_undated_events = construct_events_array_for_work_package( @work_package_pertinent_undated_events )
    
    # We create an array of dated events - past and future - in order to generate the RSS.
    @work_package_dated_events = @work_package_past_events + @work_package_future_events
    @work_package_dated_events.reverse!
  
    @page_title = "Events forming the work package for #{@work_package.work_packageable_thing_label}"
    @multiline_page_title = "#{@work_package.work_packageable_thing_label} <span class='subhead'>Work package events</span>".html_safe
    @description = "Work package for #{@work_package.work_packageable_thing_label}."
    @rss_url = work_package_event_list_url( :format => 'rss' )
    @crumb << { label: 'Work packages', url: work_package_list_url }
    @crumb << { label: @work_package.work_packageable_thing_label, url: work_package_show_url }
    @crumb << { label: 'Events', url: nil }
    @section = 'work-packages'
  end
end
