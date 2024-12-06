module Sparql::Get::ProcedureStepTypeSteps
  
  def get_procedure_step_type_steps( procedure, step_type )
    
    # We get the procedure step type steps query.
    request_body = procedure_step_type_steps_query( procedure, step_type )
    
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We construct an array to hold the steps.
    steps = []
  
    # For each row in the CSV ...
    csv.each do |row|
  
      # ... we create a new step object ...
      step = Step.new
      step.identifier = row['step']
      step.label = row['stepName']
      step.step_type_identifier = row['stepType']
      step.step_type_label = row['stepTypeLabel']
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