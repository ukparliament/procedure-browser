class WorkPackagePrimaryLegislationController < ApplicationController

  # We include modules required to get all work packages and a work package.
  include Sparql::Get::PrimaryLegislationWorkPackageCount
  include Sparql::Queries::PrimaryLegislationWorkPackageCount
  include Sparql::Get::PrimaryLegislationWorkPackages
  include Sparql::Queries::PrimaryLegislationWorkPackages
  include Sparql::Get::Response

  def index
  
    # We get the page number passed as a parameter.
    page = params['page']
    @page = ( page || "1" ).to_i
    
    # We get the number of results per page passed as a parameter.
    results_per_page = params['results-per-page']
    @results_per_page = ( results_per_page || $DEFAULT_RESULTS_PER_PAGE ).to_i
    
    # We get the count of all work packages.
    @result_count = get_primary_legislation_work_package_count
    
    # If this is not the first page and the number of the first work package on this page exceeds the total number of work packages ...
    if @page != 1 && ( ( ( @page - 1 ) * @results_per_page ) + 1 > @result_count )
      raise ActionController::RoutingError.new("Not Found")
    end
    
    # We get the set of work packages on this page with this many results per page.
    @work_packages = get_primary_legislation_work_packages( @page, @results_per_page )
    
    @page_title = 'Primary legislation work packages'
    @multiline_page_title = "Work packages <span class='subhead'>Primary legislation</span>".html_safe
    @description = 'Work packages for primary legislation.'
    @rss_url = work_package_primary_legislation_list_url( :format => 'rss' )
    @crumb << { label: 'Work packages', url: work_package_list_url }
    @crumb << { label: 'Primary legislation', url: nil }
    @section = 'work-packages'
    @subsection = 'primary-legislation'
  end
end
