class StepProcedureWithStepDepthController < ApplicationController

  # We include modules required to get a step and the procedures with step depth for a step.
  include Sparql::Get::Step
  include Sparql::Queries::Step
  include Sparql::Get::StepProceduresWithStepDepth
  include Sparql::Queries::StepProceduresWithStepDepth
  include Sparql::Get::Response

  def index
    step_id = params[:step]
    @step = get_step( step_id )
    @step_procedures_with_step_depth = get_step_procedures_with_step_depth( step_id )
    
    @page_title = "#{@step.label} - Procedures with step depth"
    @multiline_page_title = "#{@step.label} <span class='subhead'>Procedures with step depth</span>".html_safe
    @description = "Procedures with step depth for #{@step.label}."
    @crumb << { label: 'Steps', url: step_type_list_url }
    @crumb << { label: @step.step_type_label, url: step_type_show_url( :step_type => @step.step_type_id ) }
    @crumb << { label: @step.label, url: step_show_url }
    @crumb << { label: 'Procedures with step depth', url: nil }
    @section = 'steps'
    @subsection = 'procedures-with-step-depth'
  end
end
