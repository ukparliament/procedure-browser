# We require the module files for getting step types and a step type.
require 'sparql/get/step_types'
require 'sparql/get/step_type_steps'

class StepTypeController < ApplicationController

  # We include the get step types and the get step types steps modules.
  include GET_STEP_TYPES
  include GET_STEP_TYPE_STEPS

  def index
    @step_types = get_step_types
    
    @page_title = 'Steps - by type'
    @multiline_page_title = "Steps <span class='subhead'>By type</span>".html_safe
    @description = 'Procedure steps.'
    @crumb << { label: 'Steps', url: nil }
    @section = 'step-types'
  end
  
  def show
    step_type_id = params[:step_type]
    @step_type_steps = get_step_type_steps( step_type_id )
    
    @step_type = StepType.new
    @step_type.identifier = @step_type_steps.first.step_type_identifier
    @step_type.label = @step_type_steps.first.step_type_label
    @step_type.description = @step_type_steps.first.step_type_description
    
    @page_title = @step_type.label
    @description = "Steps of type #{@step_type.label}."
    @crumb << { label: 'Steps', url: step_type_list_url }
    @crumb << { label: @step_type.label, url: nil }
    @section = 'step-types'
  end
end
