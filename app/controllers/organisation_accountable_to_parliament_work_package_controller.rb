class OrganisationAccountableToParliamentWorkPackageController < ApplicationController

  # We include modules required to get an organisation accountable to Parliament.
  include Sparql::Get::OrganisationAccountableToParliament
  include Sparql::Queries::OrganisationAccountableToParliament
  include Sparql::Get::OrganisationAccountableToParliamentWorkPackageCount
  include Sparql::Queries::OrganisationAccountableToParliamentWorkPackageCount
  include Sparql::Get::OrganisationAccountableToParliamentWorkPackages
  include Sparql::Queries::OrganisationAccountableToParliamentWorkPackages
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
    
    # We get the count of all work packages made available by the organisation accountable to Parliament.
    @result_count = get_organisation_accountable_to_parliament_work_package_count( organisation_accountable_to_parliament )
    
    # If this is not the first page and the number of the first work package on this page exceeds the total number of work packages ...
    if @page != 1 && ( ( ( @page - 1 ) * @results_per_page ) + 1 > @result_count )
      raise ActionController::RoutingError.new("Not Found")
    end
    
    # We get the set of work packages made available by an organisation accountable to Parliament on this page with this many results per page.
    @work_packages = get_organisation_accountable_to_parliament_work_packages( organisation_accountable_to_parliament, @page, @results_per_page ) 
    
    @page_title = "Work packages for the #{@organisation_accountable_to_parliament.label}"
    @multiline_page_title = "#{@organisation_accountable_to_parliament.label} <span class='subhead'>Work packages</span>".html_safe
    @description = "Work packages for the  #{@organisation_accountable_to_parliament.label}."
    @rss_url = organisation_accountable_to_parliament_work_package_list_url( :format => 'rss' )
    @crumb << { label: 'Organisations accountable to Parliament', url: organisation_accountable_to_parliament_list_url }
    @crumb << { label: @organisation_accountable_to_parliament.label, url: organisation_accountable_to_parliament_show_url }
    @crumb << { label: 'Work packages', url: nil }
    @section = 'organisations-accountable-to-parliament'
    @subsection = 'work-packages'
  end
end
