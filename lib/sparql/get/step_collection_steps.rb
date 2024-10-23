module Sparql::Get::StepCollectionSteps
  
  def get_step_collection_steps( step_collection )
    
    # We get the step collection steps query.
    request_body = step_collection_steps_query( step_collection )
    
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We construct an array to hold the steps.
    steps = []
  
    # For each row in the CSV ...
    csv.each do |row|
  
      # ... we create a new step object ...
      step = Step.new
      
      # ... and add it to the array of steps.
      steps << step
      step.identifier = row['procedureStep']
      step.label = row['procedureStepName']
      step.step_type_identifier = row['procedureStepTypeName']
      step.step_type_label = row['procedureStepTypeName']
      step.commons_identifier = row['procedureStepCommonsId']
      step.lords_identifier = row['procedureStepLordsId']
      step.legislature_identifier = row['procedureSteplegislature']
      step.legislature_label = row['procedureSteplegislatureName']
    end
  
    # We return the array of steps.
    steps
  end
end