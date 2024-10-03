# We require the module files for getting steps and a step.
require 'sparql/get/steps'
require 'sparql/get/step'

class StepController < ApplicationController

  # We include the get steps and get step modules.
  include GET_STEPS
  include GET_STEP
  
  def index
    @steps = get_steps
  end
  
  def show
    step_id = params[:step]
    
    @step = get_step( step_id )
  end
end
