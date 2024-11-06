class WorkPackageController < ApplicationController

  # We include modules required to get all work packages and a work package.
  include Sparql::Get::WorkPackageCount
  include Sparql::Queries::WorkPackageCount
  include Sparql::Get::WorkPackages
  include Sparql::Queries::WorkPackages
  include Sparql::Get::WorkPackage
  include Sparql::Queries::WorkPackage
  include Sparql::Get::Response

  def index
  
    # We get the page number passed as a parameter.
    page = params['page']
    @page = ( page || "1" ).to_i
    
    # We get the number of results per page passed as a parameter.
    results_per_page = params['results-per-page']
    @results_per_page = ( results_per_page || $DEFAULT_RESULTS_PER_PAGE ).to_i
    
    # We get the count of all work packages.
    @result_count = get_work_package_count
    @result_count = 60
    
    # If the number of the first work package on this page exceeds the total number of work packages ...
    if ( ( @page - 1 ) * @results_per_page ) + 1 > @result_count
      raise ActionController::RoutingError.new("Not Found")
    end
    
    # We get the set of work packages on this page with this many results per page.
    @work_packages = get_work_packages( @page, @results_per_page )
    
    @page_title = 'Work packages'
    @description = 'All work packages.'
    @crumb << { label: 'Work packages', url: nil }
    @section = 'work-packages'
  end

  def show
    work_package_id = params[:work_package]
    @work_package = get_work_package( work_package_id )
    
    #@page_title = @work_package.label
    #@description = "Work package for #{@work_package.label}."
    @crumb << { label: 'Work packages', url: work_package_list_url }
    #@crumb << { label: @work_package.label, url: nil }
    @section = 'work-packages'
  end
end
