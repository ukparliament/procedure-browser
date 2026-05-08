class WorkPackageTreatyController < ApplicationController

  # We include modules required to get all work packages and a work package.
  include Sparql::Get::TreatyWorkPackageCount
  include Sparql::Queries::TreatyWorkPackageCount
  include Sparql::Get::TreatyWorkPackages
  include Sparql::Queries::TreatyWorkPackages
  include Sparql::Get::TreatyWorkPackagesAll
  include Sparql::Queries::TreatyWorkPackagesAll
  include Sparql::Get::Response

  def index
  
    @page_title = 'Treaty work packages'
  
    respond_to do |format|
      format.csv {
        @work_packages = get_treaty_work_packages_all
        response.headers['Content-Disposition'] = "attachment; filename=\"#{csv_title_from_page_title ( @page_title )}.csv\""
        render :template => 'work_package/index'
      }
      format.any( :html, :rss ) {
        
        # We get the page number passed as a parameter.
        page = params['page']
        @page = ( page || "1" ).to_i
    
        # We get the number of results per page passed as a parameter.
        results_per_page = params['results-per-page']
        @results_per_page = ( results_per_page || $DEFAULT_RESULTS_PER_PAGE ).to_i
    
        # We get the count of all work packages.
        @result_count = get_treaty_work_package_count
    
        # If this is not the first page and the number of the first work package on this page exceeds the total number of work packages ...
        if @page != 1 && ( ( ( @page - 1 ) * @results_per_page ) + 1 > @result_count )
          raise ActionController::RoutingError.new("Not Found")
        end
    
        # We get the set of work packages on this page with this many results per page.
        @work_packages = get_treaty_work_packages( @page, @results_per_page )
    
        @multiline_page_title = "Work packages <span class='subhead'>Treaties</span>".html_safe
        @description = 'Work packages for treaties.'
        @csv_url = work_package_treaty_list_url( :format => 'csv' )
        @rss_url = work_package_treaty_list_url( :format => 'rss' )
        @crumb << { label: 'Work packages', url: work_package_list_url }
        @crumb << { label: 'Treaties', url: nil }
        @section = 'work-packages'
        @subsection = 'treaty'
      }
    end
  end
end
