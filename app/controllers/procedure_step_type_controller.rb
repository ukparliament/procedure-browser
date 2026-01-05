class ProcedureStepTypeController < ApplicationController

  # We include modules required to get a procedure and the step types for a procedure.
  include Sparql::Get::Procedure
  include Sparql::Queries::Procedure
  include Sparql::Get::ProcedureStepTypes
  include Sparql::Queries::ProcedureStepTypes
  include Sparql::Get::ProcedureStepType
  include Sparql::Queries::ProcedureStepType
  include Sparql::Get::ProcedureStepTypeSteps
  include Sparql::Queries::ProcedureStepTypeSteps
  include Sparql::Get::Response

  def index
    procedure_id = params[:procedure]
    @procedure = get_procedure( procedure_id )
    
    # If we find a procedure with this identifier ...
    if @procedure
    
      @procedure_step_types = get_procedure_step_types( procedure_id )
    
      @page_title = "#{@procedure.label} - Step types"
      @multiline_page_title = "#{@procedure.label} <span class='subhead'>Step types</span>".html_safe
      @description = "Step types present in #{@procedure.label}."
      @crumb << { label: 'Procedures', url: procedure_list_url }
      @crumb << { label: @procedure.label, url: procedure_show_url }
      @crumb << { label: 'Step types', url: nil }
      @section = 'procedures'
      @subsection = 'steps'
    end
  end
  
  def show
    procedure_id = params[:procedure]
    step_type_id = params[:step_type]
    
    @procedure = get_procedure( procedure_id )
    
    # If we find a procedure with this identifier ...
    if @procedure
    
      @step_type = get_procedure_step_type( procedure_id, step_type_id )
    
      # If we find a step type with this identifier in this procedure ...
      if @step_type
      
        @steps = get_procedure_step_type_steps( procedure_id, step_type_id )
    
        @page_title = "#{@procedure.label} - #{@step_type.label}"
        @multiline_page_title = "#{@procedure.label} <span class='subhead'>#{@step_type.label}</span>".html_safe
        @description = "Steps of type '#{@step_type.label}' in the #{@procedure.label} procedure."
        @crumb << { label: 'Procedures', url: procedure_list_url }
        @crumb << { label: @procedure.label, url: procedure_show_url }
        @crumb << { label: 'Step types', url: procedure_step_type_list_url }
        @crumb << { label: @step_type.label, url: nil }
        @section = 'procedures'
        @subsection = 'steps'
    
        render :template => 'procedure_step_type_step/index'
      end
    end
  end
end
