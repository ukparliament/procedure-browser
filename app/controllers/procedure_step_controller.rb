class ProcedureStepController < ApplicationController

  # We include modules required to get a procedure and the step types for a procedure.
  include Sparql::Get::Procedure
  include Sparql::Queries::Procedure
  include Sparql::Get::ProcedureSteps
  include Sparql::Queries::ProcedureSteps
  include Sparql::Get::ProcedureStep
  include Sparql::Queries::ProcedureStep
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
  
  def show
    procedure_id = params[:procedure]
    @procedure = get_procedure( procedure_id )
    
    step_id = params[:step]
    @procedure_step = get_procedure_step( procedure_id, step_id )
    
    @page_title = "#{@procedure.label} - #{@procedure_step.label}"
    @multiline_page_title = "#{@procedure.label} <span class='subhead'>#{@procedure_step.label}</span>".html_safe
    @description = "Work packages subject to the #{@procedure.label} procedure, actualising '#{@procedure_step.label}'."
    
    @crumb << { label: 'Procedures', url: procedure_list_url }
    @crumb << { label: @procedure.label, url: procedure_show_url }
    @crumb << { label: 'Step types', url: procedure_step_type_list_url }
    @crumb << { label: @procedure_step.step_type_label, url: procedure_step_type_show_url( :step_type => @procedure_step.step_type_id ) }
    @crumb << { label: @procedure_step.label, url: nil }
    @section = 'procedures'
    @subsection = 'steps'
  end
end
