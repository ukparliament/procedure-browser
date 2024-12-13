module Sparql::Get::ProcedureStepCollections
  
  def get_procedure_step_collections( procedure )
    
    # We get the procedure step collections query.
    request_body = procedure_step_collections_query( procedure )
    
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
      
      # ... and add it to the array of step collections.
      step_collections << step_collection
    end
  
    # We return the array of step collections.
    step_collections
  end
end