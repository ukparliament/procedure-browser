class StepController < ApplicationController

  # We include modules required to get all steps and a step.
  include Sparql::Get::Steps
  include Sparql::Queries::Steps
  include Sparql::Get::Step
  include Sparql::Queries::Step
  include Sparql::Get::Response
  
  def index
    @steps = get_steps
    
    @page_title = 'Procedure steps'
    @description = 'Steps in procedures.'
    @crumb << { label: 'Steps', url: nil }
    @section = 'steps'
  end
  
  def show
    step_id = params[:step]
    @step = get_step( step_id )
    
    @page_title = @step.label
    @description = "#{@step.label}."
    @crumb << { label: 'Steps', url: step_type_list_url }
    @crumb << { label: @step.step_type_label, url: step_type_show_url( :step_type => @step.step_type_id ) }
    @crumb << { label: @step.label, url: nil }
    @section = 'steps'
    @subsection = 'overview'
  end
end
