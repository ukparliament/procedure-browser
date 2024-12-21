class CalculationStyleProcedureController < ApplicationController

  # We include modules required to get all calculation styles and a calculation style.
  include Sparql::Get::CalculationStyles
  include Sparql::Queries::CalculationStyles
  include Sparql::Get::CalculationStyle
  include Sparql::Queries::CalculationStyle
  include Sparql::Get::CalculationStyleProcedures
  include Sparql::Queries::CalculationStyleProcedures
  include Sparql::Get::Response

  def index
    calculation_style_id = params[:calculation_style]
    @calculation_style = get_calculation_style( calculation_style_id )
    
    @calculation_style_procedures = get_calculation_style_procedures( calculation_style_id )
    
    @page_title = "Procedures using the '#{@calculation_style.label}' calculation style"
    @multiline_page_title = "'#{@calculation_style.label}' calculation style <span class='subhead'>Procedures</span>".html_safe
    @description = "Procedures using the '#{@calculation_style.label}' calculation style."
    @crumb << { label: 'Calculation styles', url: calculation_style_list_url }
    @crumb << { label: @calculation_style.label, url: calculation_style_show_url }
    @crumb << { label: 'Procedures', url: nil }
    @section = 'calculation-styles'
  end
end
