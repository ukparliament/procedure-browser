class ProcedureCalculationStyleController < ApplicationController

  # We include modules required to get a procedure and the step types for a procedure.
  include Sparql::Get::Procedure
  include Sparql::Queries::Procedure
  include Sparql::Get::ProcedureCalculationStyles
  include Sparql::Queries::ProcedureCalculationStyles
  include Sparql::Get::Response

  def index
    procedure_id = params[:procedure]
    @procedure = get_procedure( procedure_id )
    
    # If we find a procedure with this identifier ...
    if @procedure
    
      @procedure_calculation_styles = get_procedure_calculation_styles( procedure_id )
    
      @page_title = "#{@procedure.label} - Calculation styles"
      @multiline_page_title = "#{@procedure.label} <span class='subhead'>Calculation styles</span>".html_safe
      @description = "Calculation styles for #{@procedure.label}."
      @crumb << { label: 'Procedures', url: procedure_list_url }
      @crumb << { label: @procedure.label, url: procedure_show_url }
      @crumb << { label: 'Calculation styles', url: nil }
      @section = 'procedures'
      @subsection = 'calculation-styles'
    end
  end
end
