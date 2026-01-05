class OrganisationAccountableToParliamentTreatyController < ApplicationController

  # We include modules required to get an organisation accountable to Parliament and a paginated list of treaties lead by that organisation.
  include Sparql::Get::OrganisationAccountableToParliament
  include Sparql::Queries::OrganisationAccountableToParliament
  include Sparql::Get::OrganisationAccountableToParliamentTreatyCount
  include Sparql::Queries::OrganisationAccountableToParliamentTreatyCount
  include Sparql::Get::OrganisationAccountableToParliamentTreaties
  include Sparql::Queries::OrganisationAccountableToParliamentTreaties
  include Sparql::Get::Response

  def index
  
    # We get the organisation accountable to Parliament.
    organisation_accountable_to_parliament = params[:organisation_accountable_to_parliament]
    @organisation_accountable_to_parliament = get_organisation_accountable_to_parliament( organisation_accountable_to_parliament )
    
    # If we find an organisation accountable to Parliament with this identifier ...
    if @organisation_accountable_to_parliament
  
      #  ... we get the page number passed as a parameter.
      page = params['page']
      @page = ( page || "1" ).to_i
    
      # We get the number of results per page passed as a parameter.
      results_per_page = params['results-per-page']
      @results_per_page = ( results_per_page || $DEFAULT_RESULTS_PER_PAGE ).to_i
    
      # We get the count of all treaties lead by the organisation accountable to Parliament.
      @result_count = get_organisation_accountable_to_parliament_treaty_count( organisation_accountable_to_parliament )
    
      # If this is not the first page and the number of the first work package on this page exceeds the total number of work packages ...
      if @page != 1 && ( ( ( @page - 1 ) * @results_per_page ) + 1 > @result_count )
        raise ActionController::RoutingError.new("Not Found")
      end
    
      # We get the set of treaties on this page lead by this organisation accountable to Parliament on this page with this many results per page.
      @organisation_accountable_to_parliament_treaties = get_organisation_accountable_to_parliament_treaties( organisation_accountable_to_parliament, @page, @results_per_page ) 
    
      @page_title = "Treaties lead by #{@organisation_accountable_to_parliament.label}"
      @multiline_page_title = "#{@organisation_accountable_to_parliament.label} <span class='subhead'>Treaties</span>".html_safe
      @description = "Treaties lead by #{@organisation_accountable_to_parliament.label}."
      @crumb << { label: 'Organisations accountable to Parliament', url: organisation_accountable_to_parliament_list_url }
      @crumb << { label: @organisation_accountable_to_parliament.label, url: organisation_accountable_to_parliament_show_url }
      @crumb << { label: 'Treaties', url: nil }
      @section = 'organisations-accountable-to-parliament'
      @subsection = 'treaties'
    end
  end
end
