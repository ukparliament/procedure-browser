class CalculationStyleController < ApplicationController

  # We include modules required to get all calculation styles and a calculation style.
  include Sparql::Get::CalculationStyles
  include Sparql::Queries::CalculationStyles
  include Sparql::Get::CalculationStyle
  include Sparql::Queries::CalculationStyle
  include Sparql::Get::CalculationStyleWorkPackageCount
  include Sparql::Queries::CalculationStyleWorkPackageCount
  include Sparql::Get::CalculationStyleWorkPackages
  include Sparql::Queries::CalculationStyleWorkPackages
  include Sparql::Get::Response
  
  def index
    @calculation_styles = get_calculation_styles
    
    @page_title = 'Calculation styles'
    @description = 'Calculation styles as set out in legislation.'
    @crumb << { label: 'Calculation styles', url: nil }
    @section = 'calculation-styles'
  end

  def show
    # We get the calculation style ID.
    calculation_style_id = params[:calculation_style]
    
    # We get the calculation style.
    @calculation_style = get_calculation_style( calculation_style_id )
  
    # We get the page number passed as a parameter.
    page = params['page']
    @page = ( page || "1" ).to_i
    
    # We get the number of results per page passed as a parameter.
    results_per_page = params['results-per-page']
    @results_per_page = ( results_per_page || $DEFAULT_RESULTS_PER_PAGE ).to_i
    
    # We get the count of all work packages with this calculation style.
    @result_count = get_calculation_style_work_package_count( @calculation_style.id )
    
    # If the number of the first work package on this page exceeds the total number of work packages ...
    if ( ( @page - 1 ) * @results_per_page ) + 1 > @result_count
      raise ActionController::RoutingError.new("Not Found")
    end
    
    # We get the set of work packages with this calculation style on this page with this many results per page.
    @calculation_style_work_packages = get_calculation_style_work_packages( @calculation_style.id, @page, @results_per_page )
    
    @page_title = "Work packages with the '#{@calculation_style.label}' calculation style"
    @multiline_page_title = "'#{@calculation_style.label}' calculation style <span class='subhead'>Work packages</span>".html_safe
    @description = "Work packages using the '#{@calculation_style.label}' calculation style."
    @rss_url = calculation_style_work_package_list_url( :format => 'rss' )
    @crumb << { label: 'Calculation styles', url: calculation_style_list_url }
    @crumb << { label: @calculation_style.label, url: nil }
    @section = 'calculation-styles'
    @subsection = 'work-packages'
    
    render :template => 'calculation_style_work_package/index'
  end
end
