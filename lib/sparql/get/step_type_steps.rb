# We require the module files for the step type steps query and the SPARQL response.
require 'sparql/queries/step_type_steps'
require 'sparql/get/response'

module GET_STEP_TYPE_STEPS

  Sparql::Get::StepTypeSteps = true
  
  # We include the step type steps query and SPARQL response modules.
  include STEP_TYPE_STEPS_QUERY
  include GET_RESPONSE
  
  # A method to get an array of all steps for a step type.
  def get_step_type_steps( step_type_id )
  
    # We get the step type steps query.
    request_body = step_type_steps_query( step_type_id )
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
  
    # We construct an array to hold the steps.
    steps = []
  
    # For each row in the CSV ...
    csv.each do |row|
  
      # ... we create a new step object ...
      step = Step.new
      step.identifier = row['procedureStep']
      step.label = row['procedureStepName']
    
      # ... and add it to the array of steps.
      steps << step
    end
  
    # We return the array of steps.
    steps
  end
end