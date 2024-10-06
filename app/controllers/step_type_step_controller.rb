# We require the module files for getting a step type and getting steps for a step type.
require 'sparql/get/step_type'
require 'sparql/get/step_type_steps'

class StepTypeStepController < ApplicationController

  # We include the get step type and get step type steps modules.
  include GET_STEP_TYPE
  include GET_STEP_TYPE_STEPS

  def index
    step_type_id = params[:step_type]
    @step_type = get_step_type( step_type_id )
    @step_type_steps = get_step_type_steps( step_type_id )
  
    @page_title = "#{@step_type.label} steps"
    @description = "Steps of type #{@step_type.label}."
    @crumb << { label: 'Step types', url: step_type_list_url }
    @crumb << { label: @step_type.label, url: step_type_show_url( :step_type => @step_type.id ) }
    @crumb << { label: 'Steps', url: nil }
    @section = 'step-types'
  end
end