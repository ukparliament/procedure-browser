class EnablingLegislationWorkPackageController < ApplicationController

  # We include modules required to a work package.
  include Sparql::Get::EnablingLegislation
  include Sparql::Queries::EnablingLegislation
  include Sparql::Get::EnablingLegislationWorkPackageCount
  include Sparql::Queries::EnablingLegislationWorkPackageCount
  include Sparql::Get::EnablingLegislationWorkPackages
  include Sparql::Queries::EnablingLegislationWorkPackages
  include Sparql::Get::EnablingLegislationWorkPackageCountCurrent
  include Sparql::Queries::EnablingLegislationWorkPackageCountCurrent
  include Sparql::Get::EnablingLegislationWorkPackagesCurrent
  include Sparql::Queries::EnablingLegislationWorkPackagesCurrent
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
    
    # We get the count of all work packages for the item of enabling legislation.
    @result_count = get_enabling_legislation_work_package_count( enabling_legislation )
    
    # If this is not the first page and the number of the first work package on this page exceeds the total number of work packages ...
    if @page != 1 && ( ( ( @page - 1 ) * @results_per_page ) + 1 > @result_count )
      raise ActionController::RoutingError.new("Not Found")
    end
    
    # We get the set of work packages for an item of legislation on this page with this many results per page.
    @work_packages = get_enabling_legislation_work_packages( enabling_legislation, @page, @results_per_page ) 
    
    @page_title = "#{@enabling_legislation.label} - all work packages"
    @multiline_page_title = "#{@enabling_legislation.label} <span class='subhead'>All work packages</span>".html_safe
    @description = "Work packages for instruments enabled by #{@enabling_legislation.label}."
    @rss_url = enabling_legislation_work_package_list_url( :format => 'rss' )
    @crumb << { label: 'Enabling legislation', url: enabling_legislation_list_url }
    @crumb << { label: @enabling_legislation.label, url: enabling_legislation_show_url }
    @crumb << { label: 'Work packages', url: nil }
    @section = 'enabling-legislation'
    @subsection = 'work-packages'
  end

  def current
  
    # We get the enabling legislation.
    enabling_legislation = params[:enabling_legislation]
    @enabling_legislation = get_enabling_legislation( enabling_legislation )
  
    # We get the page number passed as a parameter.
    page = params['page']
    @page = ( page || "1" ).to_i
    
    # We get the number of results per page passed as a parameter.
    results_per_page = params['results-per-page']
    @results_per_page = ( results_per_page || $DEFAULT_RESULTS_PER_PAGE ).to_i
    
    # We get the count of all work packages for the item of enabling legislation.
    @result_count = get_enabling_legislation_work_package_count_current( enabling_legislation )
    
    # If this is not the first page and the number of the first work package on this page exceeds the total number of work packages ...
    if @page != 1 && ( ( ( @page - 1 ) * @results_per_page ) + 1 > @result_count )
      raise ActionController::RoutingError.new("Not Found")
    end
    
    # We get the set of work packages for an item of legislation on this page with this many results per page.
    @work_packages = get_enabling_legislation_work_packages_current( enabling_legislation, @page, @results_per_page ) 
    
    @page_title = "#{@enabling_legislation.label} - work packages before Parliament"
    @multiline_page_title = "#{@enabling_legislation.label} <span class='subhead'>Work packages before Parliament</span>".html_safe
    @description = "Work packages for instruments enabled by #{@enabling_legislation.label} currently before Parliament."
    @canonical_url = enabling_legislation_show_url
    @rss_url = enabling_legislation_work_package_current_list_url( :format => 'rss' )
    @crumb << { label: 'Enabling legislation', url: enabling_legislation_list_url }
    @crumb << { label: @enabling_legislation.label, url: enabling_legislation_show_url }
    @crumb << { label: 'Work packages', url: enabling_legislation_work_package_list_url }
    @crumb << { label: 'Before Parliament', url: nil }
    @section = 'enabling-legislation'
    @subsection = 'work-packages-current'
  end
end
