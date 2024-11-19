class ProcedureClockController < ApplicationController

  # We include modules required to get a procedure and the step types for a procedure.
  include Sparql::Get::Procedure
  include Sparql::Queries::Procedure
  include Sparql::Get::ProcedureClocks
  include Sparql::Queries::ProcedureClocks
  include Sparql::Get::Response

  def index
    procedure_id = params[:procedure]
    @procedure = get_procedure( procedure_id )
    @procedure_clocks = get_procedure_clocks( procedure_id )
    
    @page_title = "#{@procedure.label} - Clocks"
    @multiline_page_title = "#{@procedure.label} <span class='subhead'>Clocks</span>".html_safe
    @description = "Clocks present in #{@procedure.label}."
    @crumb << { label: 'Procedures', url: procedure_list_url }
    @crumb << { label: @procedure.label, url: procedure_show_url }
    @crumb << { label: 'Clocks', url: nil }
    @section = 'procedures'
    @subsection = 'clocks'
  end
end
