module Sparql::Get::LegislatureHouses
  
  def get_legislature_houses( legislature_id )
    
    # We get the legislature houses query.
    request_body = legislature_houses_query( legislature_id )
    
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We construct an array to hold the houses.
    houses = []
  
    # For each row in the CSV ...
    csv.each do |row|
  
      # ... we create a new house object ...
      house = House.new
      house.identifier = row['House']
      house.label = row['HouseName']
      																	
      # ... and add it to the array of houses.
      houses << house
    end
  
    # We return the array of clocks.
    houses
  end
end