module Sparql::Get::RouteProcedures
  
  def get_route_procedures( route )
    
    # We get the route procedures query.
    request_body = route_procedures_query( route )
    
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
      
      # ... and add it to the array of procedures.
      procedures << procedure
    end
  
    # We return the array of procedures.
    procedures
  end
end