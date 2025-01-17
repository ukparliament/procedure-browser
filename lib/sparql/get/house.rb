module Sparql::Get::House

  # A method to get a House.
  def get_house( house_id )
  
    # We get the house query.
    request_body = house_query( house_id )
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We take the one and only row from the CSV ...
    csv.take( 1 ).each do |row|
    
      # ... and create a new house object.
      house = House.new
      house.identifier = row['House']
      house.label = row['HouseName']
      house.legislature_identifier = row['Legislature']
      house.legislature_label = row['LegislatureName']
      
      # We return the house object.
      return house
    end
  end
end