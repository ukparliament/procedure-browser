module Sparql::Get::Houses

  # A method to get an array of all houses.
  def get_houses

    # We get the houses query.
    request_body = houses_query
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
  
    # We construct an array to hold the houses.
    houses = []
  
    # For each row in the CSV ...
    csv.each do |row|
  
      # ... we create a new house object ...
      house = Legislature.new
      house.identifier = row['House']
      house.label = row['HouseName']
      
      # ... and add it to the array of houses.
      houses << house
    end
  
    # We return the array of houses.
    houses
  end
end