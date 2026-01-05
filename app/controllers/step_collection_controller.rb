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
    step_collections = get_step_collections
    
    # We create an array to hold the step collections we're interested in, being the non-mechanical step collections.
    @step_collections = []
    
    # For each step collection ...
    step_collections.each do |step_collection|
      
      # ... if the ID is in the array of mechanical step collections ...
      if @mechanical_step_collections.include?( step_collection.id )
      
        # ... we ignore it.
      # Otherwise, if the ID is not in the array of mechanical step collections ...
      else
        
        # ... we add it to the step collections array.
        @step_collections <<  step_collection
      end
    end
    
    @page_title = 'Step collections'
    @description = 'Collections of steps.'
    @crumb << { label: 'Step collections', url: nil }
    @section = 'step-collections'
  end
  
  def show
    step_collection_id = params[:step_collection]
    @step_collection = get_step_collection( step_collection_id )
    
    # If we find a step collection with this identifier ...
    if @step_collection
    
      @steps = get_step_collection_steps( step_collection_id )
    
      @page_title = @step_collection.label
      @description = "#{@step_collection.label}."
      @csv_url = step_collection_step_list_url( :format => 'csv' )
      @crumb << { label: 'Step collections', url: step_collection_list_url }
      @crumb << { label: @step_collection.label, url: nil }
      @section = 'step-collections'
      @subsection = 'steps'
    
      render :template => 'step_collection_step/index'
    end
  end
end
