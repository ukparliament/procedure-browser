# We require the module files for the steps query and the SPARQL response.
require 'sparql/queries/steps'
require 'sparql/get/response'

module GET_STEPS

  Sparql::Get::Steps = true
  
  # We include the steps query and SPARQL response modules.
  include STEPS_QUERY
  include GET_RESPONSE

  # A method to get an array of all steps.
  def get_steps

    # We get the all step query.
    request_body = steps_query
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
  
    # We construct an array to hold the steps.
    steps = []
  
    # For each row in the CSV ...
    csv.each do |row|
  
      # ... we create a new step object ...
      step = Step.new
      step.identifier = row['Step']
      step.label = row['stepName']
      step.step_type_identifier = row['stepType']
      step.step_type_label = row['stepTypeName']
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