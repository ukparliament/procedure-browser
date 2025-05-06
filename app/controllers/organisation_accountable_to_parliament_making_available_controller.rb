class OrganisationAccountableToParliamentMakingAvailableController < ApplicationController

  # We include modules required to get an organisation accountable to Parliament.
  include Sparql::Get::OrganisationAccountableToParliament
  include Sparql::Queries::OrganisationAccountableToParliament
  include Sparql::Get::OrganisationAccountableToParliamentMakingAvailableCount
  include Sparql::Queries::OrganisationAccountableToParliamentMakingAvailableCount
  include Sparql::Get::Response

  def index
  
    # We get the organisation accountable to Parliament.
    organisation_accountable_to_parliament = params[:organisation_accountable_to_parliament]
    @organisation_accountable_to_parliament = get_organisation_accountable_to_parliament( organisation_accountable_to_parliament )
  
    # We get the page number passed as a parameter.
    page = params['page']
    @page = ( page || "1" ).to_i
    
    # We get the number of results per page passed as a parameter.
    results_per_page = params['results-per-page']
    @results_per_page = ( results_per_page || $DEFAULT_RESULTS_PER_PAGE ).to_i
    
    # We get the count of all work packageable things made available by the organisation accountable to Parliament.
    @result_count = get_organisation_accountable_to_parliament_making_available_count( organisation_accountable_to_parliament )
    
    
    
    
    
    
    
    
    # If this is not the first page and the number of the first work package on this page exceeds the total number of work packages ...
    #if @page != 1 && ( ( ( @page - 1 ) * @results_per_page ) + 1 > @result_count )
      #raise ActionController::RoutingError.new("Not Found")
    #end
    
    # We get the set of work packageable things for an item of legislation on this page with this many results per page.
    #@enabling_legislation_work_packageable_things = get_enabling_legislation_work_packageable_things( enabling_legislation, @page, @results_per_page ) 
    
    @page_title = @organisation_accountable_to_parliament.label
    @description = "#{@organisation_accountable_to_parliament.label}."
    @crumb << { label: 'Organisations accountable to Parliament', url: organisation_accountable_to_parliament_list_url }
    @crumb << { label: @organisation_accountable_to_parliament.label, url: nil }
    @section = 'organisations-accountable-to-parliament'
  end
end
