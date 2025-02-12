class WorkPackageableThingController < ApplicationController

  # We include modules required to get all work packageable things and a work packageable thing.
  include Sparql::Get::WorkPackageableThingCount
  include Sparql::Queries::WorkPackageableThingCount
  include Sparql::Get::WorkPackageableThings
  include Sparql::Queries::WorkPackageableThings
  include Sparql::Get::WorkPackageableThing
  include Sparql::Queries::WorkPackageableThing
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
    @description = 'All work packageable things.'
    @rss_url = work_packageable_thing_list_url( :format => 'rss' )
    @crumb << { label: 'Work packageable things', url: nil }
    @section = 'work-packageable-things'
  end

  def show
    work_packageable_thing_id = params[:work_packageable_thing]
    @work_packageable_thing = get_work_packageable_thing( work_packageable_thing_id )
    
    #@page_title = @work_packageable_thing.label
    #@description = "#{@work_packageable_thing.label}."
    @crumb << { label: 'Work packageable things', url: work_packageable_thing_list_url }
    #@crumb << { label: @work_packageable_thing.label, url: nil }
    @section = 'work-packageable-things'
  end
end
