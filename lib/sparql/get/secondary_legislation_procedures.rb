module Sparql::Get::SecondaryLegislationProcedures

  # A method to get an array of secondary legislation procedures.
  def get_secondary_legislation_procedures

    # We get the secondary legislation procedures query.
    request_body = secondary_legislation_procedures_query
  
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
      procedure.display_order = row['procedureDisplayOrder']
      
      # ... and add it to the array of procedures.
      procedures << procedure
    end
  
    # We return the array of procedures.
    procedures
  end
end