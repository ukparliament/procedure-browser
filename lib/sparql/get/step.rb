# We require the module files for the step query and the SPARQL response.
require 'sparql/queries/step'
require 'sparql/get/response'

module GET_STEP

  Sparql::Get::Step = true
  
  # We include the step query and SPARQL response modules.
  include STEP_QUERY
  include GET_RESPONSE

  # A method to get a step.
  def get_step( step_id )
  
    # We get the all step query.
    request_body = step_query( step_id )
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
  end
end