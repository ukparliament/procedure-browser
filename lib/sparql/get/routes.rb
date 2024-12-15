module Sparql::Get::Routes

  # A method to get an array of all routes.
  def get_routes

    # We get the routes query.
    request_body = routes_query
  
    # We get the SPARQL response as a CSV.
    #csv = get_sparql_response_as_csv( request_body )
  
    # We construct an array to hold the routes.
    routes = []
  
    # For each row in the CSV ...
    #csv.each do |row|
  
      # ... we create a new route object ...
      route = Route.new
      
      # ... and add it to the array of routes.
      routes << route
    #end
  
    # We return the array of route.
    routes
  end
end