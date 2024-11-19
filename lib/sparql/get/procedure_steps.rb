module Sparql::Get::ProcedureSteps
  
  def get_procedure_steps( procedure )
    
    # We get the procedure steps query.
    request_body = procedure_steps_query( procedure )
    
    # We get the SPARQL response as a CSV.
    #csv = get_sparql_response_as_csv( request_body )
    
    # We construct an array to hold the steps.
    steps = []
  
    # For each row in the CSV ...
    #csv.each do |row|
  
      # ... we create a new step object ...
      #step = Step.new
      
      # ... and add it to the array of steps.
      #steps << step
    #end
  
    # We return the array of steps.
    steps
  end
end