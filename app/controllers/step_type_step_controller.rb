class StepTypeStepController < ApplicationController

  # We include modules required to get a step type with its steps.
  include Sparql::Get::StepTypeSteps
  include Sparql::Queries::StepTypeSteps
  include Sparql::Get::Response

  def index
    step_type_id = params[:step_type]
    @step_type_steps = get_step_type_steps( step_type_id )
    
    @step_type = StepType.new
    @step_type.identifier = @step_type_steps.first.step_type_identifier
    @step_type.label = @step_type_steps.first.step_type_label
    @step_type.description = @step_type_steps.first.step_type_description
  
    @page_title = "#{@step_type.label} - steps"
    @multiline_page_title = "#{@step_type.label} <span class='subhead'>Steps</span>".html_safe
    @description = "Steps of type #{@step_type.label}."
    @crumb << { label: 'Steps', url: step_type_list_url }
    @crumb << { label: @step_type.label, url: step_type_show_url( :step_type => @step_type.id ) }
    @crumb << { label: 'Steps', url: nil }
    @section = 'step-types'
  end
end
