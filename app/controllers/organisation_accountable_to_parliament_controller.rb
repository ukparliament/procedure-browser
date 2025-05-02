class OrganisationAccountableToParliamentController < ApplicationController

  # We include modules required to get all organisations accountable to Parliament and an organisation accountable to Parliament.
  include Sparql::Get::OrganisationsAccountableToParliamentCount
  include Sparql::Queries::OrganisationsAccountableToParliamentCount
  include Sparql::Get::OrganisationsAccountableToParliament
  include Sparql::Queries::OrganisationsAccountableToParliament
  #include Sparql::Get::OrganisationAccountableToParliament
  #include Sparql::Queries::OrganisationAccountableToParliament
  include Sparql::Get::Response

  def index
  
    # We get the page number passed as a parameter.
    page = params['page']
    @page = ( page || "1" ).to_i
    
    # We get the number of results per page passed as a parameter.
    results_per_page = params['results-per-page']
    @results_per_page = ( results_per_page || $DEFAULT_RESULTS_PER_PAGE ).to_i
    
    # We get the count of all organisations accountable to Parliament.
    @result_count = get_organisations_accountable_to_parliament_count
    
    # If this is not the first page and the number of the first organisation accountable to Parliament item on this page exceeds the total number of enabling legislation items ...
    if @page != 1 && ( ( ( @page - 1 ) * @results_per_page ) + 1 > @result_count )
      raise ActionController::RoutingError.new("Not Found")
    end
    
    # We get the set of organisation accountable to Parliament items on this page with this many results per page.
    @organisations_accountable_to_parliament = get_organisations_accountable_to_parliament( @page, @results_per_page )
    
    @page_title = 'Organisations accountable to Parliament'
    @description = 'Organisations accountable to Parliament.'
    @crumb << { label: 'Organisations accountable to Parliament', url: nil }
    @section = 'organisations-accountable-to-parliament'
  end
end
