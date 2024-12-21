class CalculationStyleController < ApplicationController

  # We include modules required to get all calculation styles and a calculation style.
  include Sparql::Get::CalculationStyles
  include Sparql::Queries::CalculationStyles
  include Sparql::Get::CalculationStyle
  include Sparql::Queries::CalculationStyle
  include Sparql::Get::Response
  
  def index
    @calculation_styles = get_calculation_styles
    
    @page_title = 'Calculation styles'
    @description = 'Calculation styles as set out in legislation.'
    @crumb << { label: 'Calculation styles', url: nil }
    @section = 'calculation-styles'
  end

  def show
    calculation_style_id = params[:calculation_style]
    @calculation_style = get_calculation_style( calculation_style_id )
    
    @page_title = "'#{@calculation_style.label}' calculation style"
    @description = "'#{@calculation_style.label}' calculation style."
    @crumb << { label: 'Calculation styles', url: calculation_style_list_url }
    @crumb << { label: @calculation_style.label, url: nil }
    @section = 'calculation-styles'
  end
end
