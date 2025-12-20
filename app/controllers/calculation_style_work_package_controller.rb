class CalculationStyleWorkPackageController < ApplicationController

  # We include modules required to get all calculation styles, a calculation style and work packages for a calculation style.
  include Sparql::Get::CalculationStyles
  include Sparql::Queries::CalculationStyles
  include Sparql::Get::CalculationStyle
  include Sparql::Queries::CalculationStyle
  include Sparql::Get::CalculationStyleWorkPackageCount
  include Sparql::Queries::CalculationStyleWorkPackageCount
  include Sparql::Get::CalculationStyleWorkPackages
  include Sparql::Queries::CalculationStyleWorkPackages
  include Sparql::Get::CalculationStyleWorkPackagesAll
  include Sparql::Queries::CalculationStyleWorkPackagesAll
  include Sparql::Get::CalculationStyleWorkPackageCountCurrent
  include Sparql::Queries::CalculationStyleWorkPackageCountCurrent
  include Sparql::Get::CalculationStyleWorkPackagesCurrent
  include Sparql::Queries::CalculationStyleWorkPackagesCurrent
  include Sparql::Get::CalculationStyleWorkPackagesCurrentAll
  include Sparql::Queries::CalculationStyleWorkPackagesCurrentAll
  include Sparql::Get::Response

  def index
    # We get the calculation style ID.
    calculation_style_id = params[:calculation_style]
    
    # We get the calculation style.
    @calculation_style = get_calculation_style( calculation_style_id )
    
    @page_title = "Work packages with the '#{@calculation_style.label}' calculation style"
    
    respond_to do |format|
      format.csv {
      
        # We get the set of work packages with this calculation style.
        @work_packages = get_calculation_style_work_packages_all( @calculation_style.id )
        
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
    
        # We get the count of all work packages with this calculation style.
        @result_count = get_calculation_style_work_package_count( @calculation_style.id )
    
        # If this is not the first page and the number of the first work package on this page exceeds the total number of work packages ...
        if @page != 1 && ( ( ( @page - 1 ) * @results_per_page ) + 1 > @result_count )
          raise ActionController::RoutingError.new("Not Found")
        end
    
        # We get the set of work packages with this calculation style on this page with this many results per page.
        @work_packages = get_calculation_style_work_packages( @calculation_style.id, @page, @results_per_page )
    
        @multiline_page_title = "'#{@calculation_style.label}' calculation style <span class='subhead'>All work packages</span>".html_safe
        @description = "Work packages using the '#{@calculation_style.label}' calculation style."
        @rss_url = calculation_style_work_package_list_url( :format => 'rss' )
        @csv_url = calculation_style_work_package_list_url( :format => 'csv' )
        @crumb << { label: 'Calculation styles', url: calculation_style_list_url }
        @crumb << { label: @calculation_style.label, url: calculation_style_show_url }
        @crumb << { label: 'Work packages', url: nil }
        @section = 'calculation-styles'
        @subsection = 'work-packages'
      }
    end
  end

  def current
    # We get the calculation style ID.
    calculation_style_id = params[:calculation_style]
    
    # We get the calculation style.
    @calculation_style = get_calculation_style( calculation_style_id )
  
    @page_title = "Work packages with the '#{@calculation_style.label}' calculation style currently before Parliament"
    
    respond_to do |format|
      format.csv {
      
        # We get the set of current work packages with this calculation style.
        @work_packages = get_calculation_style_work_packages_current_all( @calculation_style.id )
      
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
    
        # We get the count of current work packages with this calculation style.
        @result_count = get_calculation_style_work_package_current_count( @calculation_style.id )
    
        # If this is not the first page and the number of the first work package on this page exceeds the total number of work packages ...
        if @page != 1 && ( ( ( @page - 1 ) * @results_per_page ) + 1 > @result_count )
          raise ActionController::RoutingError.new("Not Found")
        end
    
        # We get the set of current work packages with this calculation style on this page with this many results per page.
        @work_packages = get_calculation_style_work_packages_current( @calculation_style.id, @page, @results_per_page )
    
        @multiline_page_title = "'#{@calculation_style.label}' calculation style <span class='subhead'>Work packages currently before Parliament</span>".html_safe
        @description = "Work packages using the '#{@calculation_style.label}' calculation style currently before Parliament."
        @canonical_url = calculation_style_show_url
        @rss_url = calculation_style_work_package_current_list_url( :format => 'rss' )
        @csv_url = calculation_style_work_package_current_list_url( :format => 'csv' )
        @crumb << { label: 'Calculation styles', url: calculation_style_list_url }
        @crumb << { label: @calculation_style.label, url: calculation_style_show_url }
        @crumb << { label: 'Work packages', url: calculation_style_work_package_list_url }
        @crumb << { label: 'Before Parliament', url: nil }
        @section = 'calculation-styles'
        @subsection = 'work-packages-current'
      }
    end
  end
end
