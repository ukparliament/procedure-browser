class CalculationStyleWorkPackageController < ApplicationController

  # We include modules required to get all calculation styles, a calculation style and work packages for a calculation style.
  include Sparql::Get::CalculationStyles
  include Sparql::Queries::CalculationStyles
  include Sparql::Get::CalculationStyle
  include Sparql::Queries::CalculationStyle
  include Sparql::Get::CalculationStyleWorkPackages
  include Sparql::Queries::CalculationStyleWorkPackages
  include Sparql::Get::Response

  def index
    calculation_style_id = params[:calculation_style]
    @calculation_style = get_calculation_style( calculation_style_id )
    
    @calculation_style_work_packages = get_calculation_style_work_packages( calculation_style_id )
    
    #@page_title = @calculation_style.label
    #@description = "#{@calculation_style.label}."
    @crumb << { label: 'Calculation styles', url: calculation_style_list_url }
    #@crumb << { label: @calculation_style.label, url: calculation_style_show_url }
    @crumb << { label: 'Work packages', url: nil }
    @section = 'calculation-styles'
  end
end
