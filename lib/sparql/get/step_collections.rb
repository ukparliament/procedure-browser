module Sparql::Get::StepCollections

  # A method to get an array of all step collections.
  def get_step_collections

    # We get the all step collections query.
    request_body = step_collections_query
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
  
    # We construct an array to hold the step collections.
    step_collections = []
  
    # For each row in the CSV ...
    csv.each do |row|
  
      # ... we create a new step collection object ...
      step_collection = StepCollection.new
      step_collection.identifier = row['StepCollection']
      step_collection.label = row['stepCollectionName']
      step_collection.procedure_identifier = row['procedure']
      step_collection.procedure_label = row['procedureName']
      step_collection.house_identifier = row['House']
      step_collection.house_label = row['HouseName']
      
      # ... and add it to the array of step collections.
      step_collections << step_collection
    end
  
    # We return the array of step collections.
    step_collections
  end
end