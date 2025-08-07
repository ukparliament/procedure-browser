module Sparql::Get::Procedure

  # A method to get a procedure.
  def get_procedure( procedure_id )
  
    # We get the procedure query.
    request_body = procedure_query( procedure_id )
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We take the one and only row from the CSV ...
    csv.take( 1 ).each do |row|
    
      # ... and create a new procedure object.
      procedure = Procedure.new
      procedure.identifier = row['Procedure']
      procedure.label = row['ProcedureName']
      procedure.description = row['ProcedureDescription']
      procedure.start_on = row['StartDate'].to_date if row['StartDate']
      procedure.end_on = row['EndDate'].to_date if row['EndDate']
      
      # We return the procedure object.
      return procedure
    end
  end
end