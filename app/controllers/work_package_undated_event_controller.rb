class WorkPackageUndatedEventController < ApplicationController

  # We include modules required to get a work package.
  include Sparql::Get::WorkPackage
  include Sparql::Queries::WorkPackage
  include Sparql::Get::WorkPackageUndatedEvents
  include Sparql::Queries::WorkPackageUndatedEvents
  include Sparql::Get::Response
  include Timeline::Timeline

  def index
    work_package_id = params[:work_package]
  
    # We get the work package.
    @work_package = get_work_package( work_package_id )
  
    # We get all the undated events for the work package.
    @work_package_events = get_work_package_undated_events( work_package_id )
  
    # We construct an array of undated events structured for display as nested lists.
    # These are an array of days containing an array of events, containing an array of steps.
    @work_package_undated_events = construct_events_array_for_work_package( @work_package_events )
  
    @page_title = "Undated events forming the work package for #{@work_package.work_packageable_thing_label}"
    @multiline_page_title = "#{@work_package.work_packageable_thing_label} <span class='subhead'>Work package undated events</span>".html_safe
    @description = "Undated events forming the work package for #{@work_package.work_packageable_thing_label}."
    @crumb << { label: 'Work packages', url: work_package_list_url }
    @crumb << { label: @work_package.work_packageable_thing_label, url: work_package_show_url }
    @crumb << { label: 'Events', url: work_package_event_list_url }
    @crumb << { label: 'Undated', url: nil }
    @section = 'work-packages'
  end
end