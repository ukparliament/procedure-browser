module Sparql::Get::CalculationStyleProcedures
  
  def get_calculation_style_procedures( calculation_style )
    
    # We get the calculation style procedures query.
    request_body = calculation_style_procedures_query( calculation_style )
    
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We construct an array to hold the procedures.
    procedures = []
  
    # For each row in the CSV ...
    csv.each do |row|
  
      # ... we create a new procedure object ...
      procedure = Procedure.new
      procedure.identifier = row['procedure']
      procedure.label = row['procedureName']
      procedure.description = row['procedureDescription']
      
      # ... and add it to the array of procedures.
      procedures << procedure
    end
  
    # We return the array of procedures.
    procedures
  end
end