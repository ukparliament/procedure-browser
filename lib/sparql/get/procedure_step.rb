module Sparql::Get::ProcedureStep

  # A method to get a step in a procedure.
  def get_procedure_step( procedure_id, step_id )
  
    # We get the procedure step query.
    request_body = procedure_step_query( procedure_id, step_id )
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # If the step doesn't exist in this procedure, the csv will be an empty array.
    # If the array is an empty array ...
    if csv.empty?
      
      # ... we render a 404 ...
      render_404
      
      # ... and return nil.
      return nil
      
    # Otherwise, if the CSV is not an empty array ...
    else
    
      # We take the one and only row from the CSV ...
      csv.take( 1 ).each do |row|
    
        # ... and create a new step object.
        step = Step.new
        step.identifier = row['step']
        step.label = row['stepName']
        step.description = row['description']
        step.legislature_identifier = row['legislature']
        step.legislature_label = row['legislatureName']
        step.commons_identifier = row['CommonsId']
        step.lords_identifier = row['LordsId']
        step.step_type_identifier = row['stepType']
        step.step_type_label = row['stepTypeLabel']
      
        # We return the step object.
        return step
      end
    end
  end
end