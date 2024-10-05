# We require the module files for the step type query and the SPARQL response.
require 'sparql/queries/step_type'
require 'sparql/get/response'

module GET_STEP_TYPE

  Sparql::Get::StepType = true
  
  # We include the step type query and SPARQL response modules.
  include STEP_TYPE_QUERY
  include GET_RESPONSE

  # A method to get a step type.
  def get_step_type( step_type_id )
  
    # We get the all step types query.
    request_body = step_type_query( step_type_id )
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We take the one and only row from the CSV ...
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