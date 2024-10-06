# We require the module files for getting step types and a step type.
require 'sparql/get/step_types'
require 'sparql/get/step_type'

class StepTypeController < ApplicationController

  # We include the get step types and get step type modules.
  include GET_STEP_TYPES
  include GET_STEP_TYPE

  def index
    @step_types = get_step_types
    
    @page_title = 'Step types'
    @description = 'Types of procedure steps.'
    @crumb << { label: 'Step types', url: nil }
    @section = 'step-types'
  end
  
  def show
    step_type_id = params[:step_type]
    @step_type = get_step_type( step_type_id )
    
    @page_title = @step_type.label
    @description = "#{@step_type.description}."
    @crumb << { label: 'Step types', url: step_type_list_url }
    @crumb << { label: @step_type.label, url: nil }
    @section = 'step-types'
  end
end
