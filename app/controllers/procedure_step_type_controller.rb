class ProcedureStepTypeController < ApplicationController

  # We include modules required to get a procedure and the step types for a procedure.
  include Sparql::Get::Procedure
  include Sparql::Queries::Procedure
  include Sparql::Get::ProcedureStepTypes
  include Sparql::Queries::ProcedureStepTypes
  include Sparql::Get::Response

  def index
    procedure_id = params[:procedure]
    @procedure = get_procedure( procedure_id )
    @procedure_step_types = get_procedure_step_types( procedure_id )
    
    @page_title = "#{@procedure.label} - Step types"
    @multiline_page_title = "#{@procedure.label} <span class='subhead'>Step types</span>".html_safe
    @description = "Step types present in #{@procedure.label}."
    @crumb << { label: 'Procedures', url: procedure_list_url }
    @crumb << { label: @procedure.label, url: procedure_show_url }
    @crumb << { label: 'Step types', url: nil }
    @section = 'procedures'
    @subsection = 'step-types'
  end
end
