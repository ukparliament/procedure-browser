class StepCollectionController < ApplicationController

  # We include modules required to get all step collections and a step collection.
  include Sparql::Get::StepCollections
  include Sparql::Queries::StepCollections
  include Sparql::Get::StepCollection
  include Sparql::Queries::StepCollection
  include Sparql::Get::StepCollectionSteps
  include Sparql::Queries::StepCollectionSteps
  include Sparql::Get::Response
  
  def index
    @step_collections = get_step_collections
    
    @page_title = 'Step collections'
    @description = 'Collections of steps.'
    @crumb << { label: 'Step collections', url: nil }
    @section = 'step-collections'
  end
  
  def show
    step_collection_id = params[:step_collection]
    @step_collection = get_step_collection( step_collection_id )
    @step_collection_steps = get_step_collection_steps( step_collection_id )
    
    @page_title = @step_collection.label
    @description = "#{@step_collection.label}."
    @crumb << { label: 'Step collections', url: step_collection_list_url }
    @crumb << { label: @step_collection.label, url: nil }
    @section = 'step-collections'
    
    render :template => 'step_collection_step/index'
  end
end
