module Sparql::Get::StepTypeSteps
  
  # A method to get an array of all steps for a step type.
  def get_step_type_steps( step_type_id )
  
    # We get the step type steps query.
    request_body = step_type_steps_query( step_type_id )
  
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
  
      #... we construct an array to hold the steps.
      steps = []
  
      # For each row in the CSV ...
      csv.each do |row|
  
        # ... we create a new step object ...
        step = Step.new
        step.identifier = row['Step']
        step.label = row['StepName']
        step.step_type_identifier = row['StepType']
        step.step_type_label = row['stepTypeName']
        step.step_type_description = row['stepTypeDescription']
        step.legislature_identifier = row['legislature']
        step.legislature_label = row['legislatureName']
        step.commons_identifier = row['CommonsId']
        step.lords_identifier = row['LordsId']
      
        # ... and add it to the array of steps.
        steps << step
      end
  
      # We return the array of steps.
      steps
    end
  end
end