class StepCollectionStepController < ApplicationController

  # We include modules required to get a step collection.
  include Sparql::Get::StepCollection
  include Sparql::Queries::StepCollection
  include Sparql::Get::StepCollectionSteps
  include Sparql::Queries::StepCollectionSteps
  include Sparql::Get::Response
  
  def index
    step_collection_id = params[:step_collection]
    @step_collection = get_step_collection( step_collection_id )
    @step_collection_steps = get_step_collection_steps( step_collection_id )
    
    @page_title = "#{@step_collection.label} - Steps"
    @multiline_page_title = "#{@step_collection.label} <span class='subhead'>Steps</span>".html_safe
    @description = "Steps in the '#{@step_collection.label}' step collection."
    @canonical_url = step_collection_show_url
    @crumb << { label: 'Step collections', url: step_collection_list_url }
    @crumb << { label: @step_collection.label, url: step_collection_show_url }
    @crumb << { label: 'Steps', url: nil }
    @section = 'step-collections'
    @subsection = 'steps'
  end
end
