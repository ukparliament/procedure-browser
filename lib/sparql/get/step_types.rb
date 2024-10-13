module Sparql::Get::StepTypes

  # A method to get an array of all step types.
  def get_step_types
  
    # We get the all step types query.
    request_body = step_types_query

    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )

    # We construct an array to hold the step types.
    step_types = []
    
    # For each row in the CSV ...
    csv.each do |row|
  
      # ... we create a new step type object ...
      step_type = StepType.new
      step_type.identifier = row['StepType']
      step_type.label = row['stepTypeName']
    
      # ... and add it to the array of steps.
      step_types << step_type
    end
  
    # We return the array of step types.
    step_types
  end
end