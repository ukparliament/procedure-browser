module Sparql::Get::ProcedureRoutes
  
  def get_procedure_routes( procedure )
    
    # We get the procedure routes query.
    request_body = procedure_routes_query( procedure )
    
    # We get the SPARQL response as a CSV.
    #csv = get_sparql_response_as_csv( request_body )
    
    # We construct an array to hold the routes.
    routes = []
  
    # For each row in the CSV ...
    #csv.each do |row|
  
      # ... we create a new route object ...
      #route = Route.new
      
      # ... and add it to the array of routes.
      #routes << route
    #end
  
    # We return the array of routes.
    routes
  end
end