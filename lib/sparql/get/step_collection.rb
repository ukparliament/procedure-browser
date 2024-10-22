module Sparql::Get::StepCollection

  # A method to get a step collection.
  def get_step_collection( step_collection_id )
  
    # We get the all step collections query.
    request_body = step_collection_query( step_collection_id )
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We take the one and only row from the CSV ...
    csv.take( 1 ).each do |row|
    
      # ... and create a new step collection object.
      step_collection = StepCollection.new
      step_collection.identifier = row['StepCollection']
      step_collection.label = row['stepCollectionName']
      step_collection.procedure_identifier = row['procedure']
      step_collection.procedure_label = row['procedureName']
      step_collection.house_identifier = row['House']
      step_collection.house_label = row['HouseName']
      
      # We return the step collection object.
      return step_collection
    end
  end
end