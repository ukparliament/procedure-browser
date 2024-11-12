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
    
    # We create arrays to hold past events, future events and undated events.
    @work_package_past_events = []
    @work_package_future_events = []
    @work_package_undated_events = []
    
    # For each item in the work package events array ...
    @work_package_events.each do |wpe|
      if wpe.date
        if wpe.date <= Date.today
          @work_package_past_events << wpe
        else
          @work_package_future_events << wpe
        end
      else
        @work_package_undated_events << wpe
      end
    end
    
    @page_title = "Work package for #{@work_package.work_packageable_thing_label}"
    @multiline_page_title = "#{@work_package.work_packageable_thing_label} <span class='subhead'>Work package</span>".html_safe
    @description = "Work package for #{@work_package.work_packageable_thing_label}."
    @crumb << { label: 'Work packages', url: work_package_list_url }
    #@crumb << { label: @work_package.work_packageable_thing_label, url: nil }
    @section = 'work-packages'
    
    render :template => 'work_package_events/index'
  end
end
