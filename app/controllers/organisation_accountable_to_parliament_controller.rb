class OrganisationAccountableToParliamentController < ApplicationController

  # We include modules required to get all organisations accountable to Parliament and an organisation accountable to Parliament.
  include Sparql::Get::OrganisationsAccountableToParliamentCount
  include Sparql::Queries::OrganisationsAccountableToParliamentCount
  include Sparql::Get::OrganisationsAccountableToParliament
  include Sparql::Queries::OrganisationsAccountableToParliament
  include Sparql::Get::OrganisationsAccountableToParliamentCountCurrent
  include Sparql::Queries::OrganisationsAccountableToParliamentCountCurrent
  include Sparql::Get::OrganisationsAccountableToParliamentCurrent
  include Sparql::Queries::OrganisationsAccountableToParliamentCurrent
  include Sparql::Get::OrganisationAccountableToParliament
  include Sparql::Queries::OrganisationAccountableToParliament
  
  
  
  include Sparql::Get::OrganisationAccountableToParliamentWorkPackageCountCurrent
  include Sparql::Queries::OrganisationAccountableToParliamentWorkPackageCountCurrent
  include Sparql::Get::OrganisationAccountableToParliamentWorkPackagesCurrent
  include Sparql::Queries::OrganisationAccountableToParliamentWorkPackagesCurrent
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
    @multiline_page_title = "Organisations accountable to Parliament <span class='subhead'>All</span>".html_safe
    @description = 'Organisations accountable to Parliament.'
    @crumb << { label: 'Organisations accountable to Parliament', url: nil }
    @section = 'organisations-accountable-to-parliament'
    @subsection = 'all'
  end

  def current
  
    # We get the page number passed as a parameter.
    page = params['page']
    @page = ( page || "1" ).to_i
    
    # We get the number of results per page passed as a parameter.
    results_per_page = params['results-per-page']
    @results_per_page = ( results_per_page || $DEFAULT_RESULTS_PER_PAGE ).to_i
    
    # We get the count of current organisations accountable to Parliament.
    @result_count = get_organisations_accountable_to_parliament_count_current
    
    # If this is not the first page and the number of the first organisation accountable to Parliament item on this page exceeds the total number of enabling legislation items ...
    if @page != 1 && ( ( ( @page - 1 ) * @results_per_page ) + 1 > @result_count )
      raise ActionController::RoutingError.new("Not Found")
    end
    
    # We get the set of organisation accountable to Parliament items on this page with this many results per page.
    @organisations_accountable_to_parliament = get_organisations_accountable_to_parliament_current( @page, @results_per_page )
    
    @page_title = 'Organisations accountable to Parliament'
    @multiline_page_title = "Organisations accountable to Parliament <span class='subhead'>Current</span>".html_safe
    @description = 'Organisations accountable to Parliament.'
    @crumb << { label: 'Organisations accountable to Parliament', url: organisation_accountable_to_parliament_list_url }
    @crumb << { label: 'Current', url: nil }
    @section = 'organisations-accountable-to-parliament'
    @subsection = 'current'
  end
  
  def show
  
    # We get the organisation accountable to Parliament.
    organisation_accountable_to_parliament = params[:organisation_accountable_to_parliament]
    @organisation_accountable_to_parliament = get_organisation_accountable_to_parliament( organisation_accountable_to_parliament )
  
    # We get the page number passed as a parameter.
    page = params['page']
    @page = ( page || "1" ).to_i
    
    # We get the number of results per page passed as a parameter.
    results_per_page = params['results-per-page']
    @results_per_page = ( results_per_page || $DEFAULT_RESULTS_PER_PAGE ).to_i
    
    # We get the count of current work packages for the organisation accountable to Parliament.
    @result_count = get_organisation_accountable_to_parliament_work_package_current_count( organisation_accountable_to_parliament )
    
    # If this is not the first page and the number of the first work package on this page exceeds the total number of work packages ...
    #if @page != 1 && ( ( ( @page - 1 ) * @results_per_page ) + 1 > @result_count )
      #raise ActionController::RoutingError.new("Not Found")
    #end
    
    # We get the set of current work packages for an organsation accountable to Parliament on this page with this many results per page.
    @work_packages = get_organisation_accountable_to_parliament_current_work_packages( organisation_accountable_to_parliament, @page, @results_per_page )
    
    @page_title = "Work packages for the #{@organisation_accountable_to_parliament.label} before Parliament"
    @multiline_page_title = "#{@organisation_accountable_to_parliament.label} <span class='subhead'>Work packages before Parliament</span>".html_safe
    @description = "Work packages for the #{@organisation_accountable_to_parliament.label} currently before Parliament."
    @rss_url = organisation_accountable_to_parliament_work_package_current_list_url( :format => 'rss' )
    @crumb << { label: 'Organisations accountable to Parliament', url: organisation_accountable_to_parliament_list_url }
    @crumb << { label: @organisation_accountable_to_parliament.label, url: nil }
    @section = 'organisations-accountable-to-parliament'
    @subsection = 'work-packages-current'
    
    render :template => 'organisation_accountable_to_parliament_work_package/current'
  end
end
