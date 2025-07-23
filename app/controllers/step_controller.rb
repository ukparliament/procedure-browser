class StepController < ApplicationController

  # We include modules required to get all steps and a step.
  include Sparql::Get::Steps
  include Sparql::Queries::Steps
  include Sparql::Get::Step
  include Sparql::Queries::Step
  include Sparql::Get::StepBusinessItems
  include Sparql::Queries::StepBusinessItems
  include Sparql::Get::Response
  
  def index
    @steps = get_steps
    
    @page_title = 'Steps'
    @description = 'Steps in procedures.'
    @crumb << { label: 'Steps', url: nil }
    @section = 'steps'
  end
  
  def show
    step_id = params[:step]
    @step = get_step( step_id )
    @step_business_items = get_step_business_items( step_id )
    
    @page_title = @step.display_label
    @description = "#{@step.display_label}."
    @crumb << { label: 'Steps', url: step_type_list_url }
    @crumb << { label: @step.step_type_label, url: step_type_show_url( :step_type => @step.step_type_id ) }
    @crumb << { label: @step.label, url: nil }
    @section = 'steps'
    @subsection = 'business-items'
    
    render :template => 'step_business_item/index'
  end
end
