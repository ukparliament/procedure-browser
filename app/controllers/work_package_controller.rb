class WorkPackageController < ApplicationController

  # We include modules required to get all work packages and a work package.
  include Sparql::Get::WorkPackageCount
  include Sparql::Queries::WorkPackageCount
  include Sparql::Get::WorkPackages
  include Sparql::Queries::WorkPackages
  include Sparql::Get::WorkPackage
  include Sparql::Queries::WorkPackage
  include Sparql::Get::WorkPackageEvents
  include Sparql::Queries::WorkPackageEvents
  include Sparql::Get::Response

  def index
  
    # We get the page number passed as a parameter.
    page = params['page']
    @page = ( page || "1" ).to_i
    
    # We get the number of results per page passed as a parameter.
    results_per_page = params['results-per-page']
    @results_per_page = ( results_per_page || $DEFAULT_RESULTS_PER_PAGE ).to_i
    
    # We get the count of all work packages.
    @result_count = get_work_package_count
    
    # If the number of the first work package on this page exceeds the total number of work packages ...
    if ( ( @page - 1 ) * @results_per_page ) + 1 > @result_count
      raise ActionController::RoutingError.new("Not Found")
    end
    
    # We get the set of work packages on this page with this many results per page.
    @work_packages = get_work_packages( @page, @results_per_page )
    
    @page_title = 'Work packages'
    @description = 'All work packages.'
    @rss_url = work_package_list_url( :format => 'rss' )
    @crumb << { label: 'Work packages', url: nil }
    @section = 'work-packages'
  end

  def show
    work_package_id = params[:work_package]
    
    # We get the work package.
    @work_package = get_work_package( work_package_id )
    
    # We get all the events for the work package.
    @work_package_events = get_work_package_events( work_package_id )
    
    # We get arrays of pertinent past events, future events and undated events.
    @work_package_pertinent_past_events = get_pertinent_events( @work_package_events, 'past' )
    @work_package_pertinent_future_events = get_pertinent_events( @work_package_events, 'future' )
    @work_package_pertinent_undated_events = get_pertinent_events( @work_package_events, 'undated' )
    
    # We get arrays of past events, future events and undated events structured for display as nested lists.
    # These are an array of days containing an array of events, containing an array of steps.
    @work_package_past_events = get_past_events_for_work_package( @work_package_pertinent_past_events )
    @work_package_future_events = get_past_events_for_work_package( @work_package_pertinent_future_events )
    @work_package_undated_events = get_past_events_for_work_package( @work_package_pertinent_undated_events )
    
    @page_title = "Work package for #{@work_package.work_packageable_thing_label}"
    @multiline_page_title = "#{@work_package.work_packageable_thing_label} <span class='subhead'>Work package</span>".html_safe
    @description = "Work package for #{@work_package.work_packageable_thing_label}."
    @crumb << { label: 'Work packages', url: work_package_list_url }
    @crumb << { label: @work_package.work_packageable_thing_label, url: nil }
    @section = 'work-packages'
    
    render :template => 'work_package_event/index'
  end
end

# A method to get pertinent events of a type.
def get_pertinent_events( work_package_events, type )

  # We create an array to hold pertinent events.
  pertinent_events = []
  
  # For each item in the work package events array ...
  work_package_events.each do |event|
  
    # We check the type ...
    case type
    
      # ... and when the type is 'past' events ...
      when 'past'
    
        # ... if the event has a date and the date is today or earlier ...
        if ( event.date ) && ( event.date <= Date.today )
      
          # ... we add the event to the array of pertinent events.
          pertinent_events << event
        end
    
      # Otherwise, if the type is 'future' events ...
      when 'future'
      
        # ... if the event has a date and the date is later than today ...
        if ( event.date ) && ( event.date > Date.today )
    
          # ... we add the event to the array of pertinent events.
          pertinent_events << event
        end
          
      # Otherwise, if the type is 'undated' events ...
      when 'undated'
    
        # ... if the event has no date ...
        unless event.date
    
          # ... we add the event to the array of pertinent events.
          pertinent_events << event
        end
    end
  end
  
  # We return the pertinent events array.
  pertinent_events
end

# A method to get past events for a work package.
def get_past_events_for_work_package( pertinent_events )

  # We create an array to hold dates for a event list view of a work package.
  dates = []
  
  # For each pertinent event ...
  pertinent_events.each_with_index do |pertinent_event, index|
  
    # ... if this is the first pertinent event ...
    if index == 0
    
      # ... we know it's a new step for a new event on a new date.
      # We create a new array of steps inside a new array of events and add the events array to the dates array.
      dates << Array[Array[pertinent_event]]
      
    # Otherwise, if this is not the first pertinent event ...
    else
      
      # ... if this event has a different date to the preceding event ...
      if pertinent_event.date != pertinent_events[index - 1].date
    
        # ... we know it's a new step for a new event on a new date.
        # We create a new array of steps inside a new array of events and add the events array to the dates array.
        dates << Array[Array[pertinent_event]]
        
      # Otherwise, if this event has the same date as the preceding event ...
      else
        
        # ... if this event has a different identifier to the preceding event ...
        if pertinent_event.identifier != pertinent_events[index - 1].identifier
        
          # ... we know it's a new step for a new event on an existing date.
          # We create a new array of events containing the new step and add it to the last date.
          dates.last << Array[pertinent_event]
          
        # Otherwise, if this event has the same identifier as the preceding event ...
        else
        
          # ... we know this is a new step for an existing event on an existing date.
          # We add the event to the last event array of the last date.
          dates.last.last << pertinent_event
        end
      end
    end
    
  end
  
  # We return the array of events for a work package.
  dates
end
