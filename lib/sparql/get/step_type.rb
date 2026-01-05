module Sparql::Get::StepType

  # A method to get a step type.
  def get_step_type( step_type_id )
  
    # We get the all step types query.
    request_body = step_type_query( step_type_id )
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # If the step type doesn't exist, the csv will be an empty array.
    # If the array is an empty array ...
    if csv.empty?
      
      # ... we render a 404 ...
      render_404
      
      # ... and return nil.
      return nil
      
    # Otherwise, if the CSV is not an empty array ...
    else
    
      # ... we take the one and only row from the CSV ...
      csv.take( 1 ).each do |row|
    
        # ... and create a new step type object.
        step_type = StepType.new
        step_type.identifier = row['StepType']
        step_type.label = row['stepTypeName']
        step_type.description = row['stepTypeDescription']
      
        # We return the step type object.
        return step_type
      end
    end
  end
end