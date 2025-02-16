class EnablingLegislationWorkPackageableThingController < ApplicationController

  # We include modules required to a work package.
  include Sparql::Get::EnablingLegislation
  include Sparql::Queries::EnablingLegislation
  include Sparql::Get::EnablingLegislationWorkPackageableThingCount
  include Sparql::Queries::EnablingLegislationWorkPackageableThingCount
  include Sparql::Get::EnablingLegislationWorkPackageableThings
  include Sparql::Queries::EnablingLegislationWorkPackageableThings
  include Sparql::Get::Response

  def index
  
    # We get the enabling legislation.
    enabling_legislation = params[:enabling_legislation]
    @enabling_legislation = get_enabling_legislation( enabling_legislation )
  
    # We get the page number passed as a parameter.
    page = params['page']
    @page = ( page || "1" ).to_i
    
    # We get the number of results per page passed as a parameter.
    results_per_page = params['results-per-page']
    @results_per_page = ( results_per_page || $DEFAULT_RESULTS_PER_PAGE ).to_i
    
    # We get the count of all work packageable things for the item of enabling legislation.
    @result_count = get_enabling_legislation_work_packageable_thing_count( enabling_legislation )
    
    # If this is not the first page and the number of the first work package on this page exceeds the total number of work packages ...
    if @page != 1 && ( ( ( @page - 1 ) * @results_per_page ) + 1 > @result_count )
      raise ActionController::RoutingError.new("Not Found")
    end
    
    # We get the set of work packageable things for an item of legislation on this page with this many results per page.
    @enabling_legislation_work_packageable_things = get_enabling_legislation_work_packageable_things( enabling_legislation, @page, @results_per_page ) 
    
    
    
    
    
    
    
    
    
    #@page_title = @enabling_legislation.label
    #@description = "#{@enabling_legislation.label}."
    @crumb << { label: 'Enabling legislation', url: enabling_legislation_list_url }
    #@crumb << { label: @enabling_legislation.label, url: nil }
    @section = 'enabling-legislation'
  end
end
