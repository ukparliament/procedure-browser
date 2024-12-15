module Sparql::Get::Route

  # A method to get a route.
  def get_route( route_id )
  
    # We get the route query.
    request_body = route_query( route_id )
  
    # We get the SPARQL response as a CSV.
    #csv = get_sparql_response_as_csv( request_body )
    
    # We take the one and only row from the CSV ...
    #csv.take( 1 ).each do |row|
    
      # ... and create a new route object.
      route = Route.new
      
      # We return the route object.
      return route
    #end
  end
end