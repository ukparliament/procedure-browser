module Sparql::Get::ProcedureStepType

  # A method to get a step type in a procedure.
  def get_procedure_step_type( procedure_id, step_type_id )
  
    # We get the procedure step type query.
    request_body = procedure_step_type_query( procedure_id, step_type_id )
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We take the one and only row from the CSV ...
    csv.take( 1 ).each do |row|
    
      # ... and create a new step type object.
      step_type = StepType.new
      step_type.identifier = row['stepType']
      step_type.label = row['stepTypeLabel']
      
      # We return the step type object.
      return step_type
    end
  end
end