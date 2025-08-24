class WorkPackageableThingController < ApplicationController

  # We include modules required to get all work packageable things and a work packageable thing.
  include Sparql::Get::WorkPackageableThingCount
  include Sparql::Queries::WorkPackageableThingCount
  include Sparql::Get::WorkPackageableThings
  include Sparql::Queries::WorkPackageableThings
  include Sparql::Get::WorkPackageableThingCountCurrent
  include Sparql::Queries::WorkPackageableThingCountCurrent
  include Sparql::Get::WorkPackageableThingsCurrent
  include Sparql::Queries::WorkPackageableThingsCurrent
  include Sparql::Get::WorkPackageableThing
  include Sparql::Queries::WorkPackageableThing
  include Sparql::Get::WorkPackageableThingWorkPackages
  include Sparql::Queries::WorkPackageableThingWorkPackages
  include Sparql::Get::Response

  def index
  
    # We get the page number passed as a parameter.
    page = params['page']
    @page = ( page || "1" ).to_i
    
    # We get the number of results per page passed as a parameter.
    results_per_page = params['results-per-page']
    @results_per_page = ( results_per_page || $DEFAULT_RESULTS_PER_PAGE ).to_i
    
    # We get the count of all work packageable things.
    @result_count = get_work_packageable_thing_count
    
    # If this is not the first page and the number of the first work package on this page exceeds the total number of work packages ...
    if @page != 1 && ( ( ( @page - 1 ) * @results_per_page ) + 1 > @result_count )
      raise ActionController::RoutingError.new("Not Found")
    end
    
    # We get the set of work packageable things on this page with this many results per page.
    @work_packageable_things = get_work_packageable_things( @page, @results_per_page )
    
    @page_title = 'Work packageable things'
    @multiline_page_title = "Work packageable things <span class='subhead'>All</span>".html_safe
    @description = 'All work packageable things.'
    @crumb << { label: 'Work packageable things', url: nil }
    @section = 'work-packages'
    @subsection = 'all'
  end
  
  def current
  
    # We get the page number passed as a parameter.
    page = params['page']
    @page = ( page || "1" ).to_i
    
    # We get the number of results per page passed as a parameter.
    results_per_page = params['results-per-page']
    @results_per_page = ( results_per_page || $DEFAULT_RESULTS_PER_PAGE ).to_i
    
    # We get the count of current work packageable things.
    @result_count = get_work_packageable_thing_count_current
    
    # If this is not the first page and the number of the first work package on this page exceeds the total number of work packages ...
    if @page != 1 && ( ( ( @page - 1 ) * @results_per_page ) + 1 > @result_count )
      raise ActionController::RoutingError.new("Not Found")
    end
    
    # We get the set of work packageable things on this page with this many results per page.
    @work_packageable_things = get_work_packageable_things_current( @page, @results_per_page )
    
    @page_title = 'Work packageable things before Parliament'
    @multiline_page_title = "Work packageable things <span class='subhead'>Before Parliament</span>".html_safe
    @description = 'Work packageable things before Parliament.'
    @crumb << { label: 'Work packageable things', url: work_packageable_thing_list_url }
    @crumb << { label: 'Before Parliament', url: nil }
    @section = 'work-packages'
    @subsection = 'current'
  end

  def show
    work_packageable_thing_id = params[:work_packageable_thing]
    @work_packageable_thing = get_work_packageable_thing( work_packageable_thing_id )
    
    # We get all work packages for this work packageable thing.
    @work_packageable_thing_work_packages = get_work_packageable_thing_work_packages( work_packageable_thing_id )
    
    @page_title = @work_packageable_thing.label
    @description = "#{@work_packageable_thing.label}."
    @crumb << { label: 'Work packageable things', url: work_packageable_thing_list_url }
    @crumb << { label: @work_packageable_thing.label, url: nil }
    @section = 'work-packages'
    @subsection = 'work-packages'
    
    render :template => 'work_packageable_thing_work_package/index'
  end
end
