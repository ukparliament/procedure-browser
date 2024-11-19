class ProcedureStepController < ApplicationController

  # We include modules required to get a procedure and the step types for a procedure.
  include Sparql::Get::Procedure
  include Sparql::Queries::Procedure
  include Sparql::Get::ProcedureSteps
  include Sparql::Queries::ProcedureSteps
  include Sparql::Get::Response

  def index
    procedure_id = params[:procedure]
    @procedure = get_procedure( procedure_id )
    @procedure_steps = get_procedure_steps( procedure_id )
    
    @page_title = "#{@procedure.label} - Steps"
    @multiline_page_title = "#{@procedure.label} <span class='subhead'>Steps</span>".html_safe
    @description = "Steps present in #{@procedure.label}."
    @crumb << { label: 'Procedures', url: procedure_list_url }
    @crumb << { label: @procedure.label, url: procedure_show_url }
    @crumb << { label: 'Steps', url: nil }
    @section = 'procedures'
    @subsection = 'steps'
  end
end
