class StepCollectionController < ApplicationController

  # We include modules required to get all step collections and a step collection.
  include Sparql::Get::StepCollections
  include Sparql::Queries::StepCollections
  #include Sparql::Get::StepCollection
  #include Sparql::Queries::StepCollection
  include Sparql::Get::Response
  
  def index
    @step_collections = get_step_collections
    
    @page_title = 'Step collections'
    @description = 'Collections of steps.'
    @crumb << { label: 'Step collections', url: nil }
    @section = 'step-collections'
  end
  
  def show
    @page_title = 'Coming soon'
    render :template => 'under_construction/notice'
  end
end
