module Sparql::Get::ProcedureStepTypes
  
  def get_procedure_step_types( procedure )
    
    # We get the procedure step types query.
    request_body = procedure_step_types_query( procedure )
    
    # We get the SPARQL response as a CSV.
    #csv = get_sparql_response_as_csv( request_body )
    
    # We construct an array to hold the events.
    step_types = []
  
    # For each row in the CSV ...
    #csv.each do |row|
  
      # ... we create a new step type object ...
      #step_type = StepType.new
      
      # ... and add it to the array of step types.
      #step_types << step_type
    #end
  
    # We return the array of step types.
    step_types
  end
end