# We require the module file for the step work packageable things query and the SPARQL response.
require 'sparql/queries/step_step_collections'
require 'sparql/get/response'

module GET_STEP_STEP_COLLECTIONS

  Sparql::Get::StepStepCollections = true
  
  # We include the step step collections query and SPARQL response modules.
  include STEP_STEP_COLLECTIONS_QUERY
  include GET_RESPONSE
  
  def get_step_step_collections( step )
    
    # We get the step step collections query.
    request_body = step_step_collections_query( step )
    
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We construct an array to hold the step collections.
    step_collections = []
  
    # For each row in the CSV ...
    csv.each do |row|
  
      # ... we create a new step collection object ...
      step_collection = StepCollection.new
      step_collection.identifier = row['stepCollection']
      step_collection.label = row['stepCollectionLabel']
      step_collection.procedure_identifier = row['procedure']
      step_collection.procedure_label = row['procedureName']
      step_collection.house_identifier = row['House']
      step_collection.house_label = row['House']
      step_collection.membership_identifier = row['stepCollectionMembership']
      
      # ... and add it to the array of step collections.
      step_collections << step_collection
    end
  
    # We return the array of step collections.
    step_collections
  end
end