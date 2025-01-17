module Sparql::Get::LegislatureSteps
  
  def get_legislature_steps( legislature_id )
    
    # We get the legislature steps query.
    request_body = legislature_steps_query( legislature_id )
    
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We construct an array to hold the steps.
    steps = []
  
    # For each row in the CSV ...
    csv.each do |row|
  
      # ... we create a new step object ...
      step = Step.new
      step.identifier = row['Step']
      step.label = row['StepName']
      step.step_type_identifier = row['StepType']
      step.step_type_label = row['StepTypeName']
      																	
      # ... and add it to the array of steps.
      steps << step
    end
  
    # We return the array of steps.
    steps
  end
end