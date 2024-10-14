module Sparql::Get::StepStepCollections
  
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
      step_collection.house_label = row['HouseName']
      step_collection.membership_identifier = row['stepCollectionMembership']
      
      # ... and add it to the array of step collections.
      step_collections << step_collection
    end
  
    # We return the array of step collections.
    step_collections
  end
end