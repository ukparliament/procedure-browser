module Sparql::Get::Legislature

  # A method to get a legislature.
  def get_legislature( legislature_id )
  
    # We get the legislature query.
    request_body = legislature_query( legislature_id )
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We take the one and only row from the CSV ...
    csv.take( 1 ).each do |row|
    
      # ... and create a new legislature object.
      legislature = Legislature.new
      legislature.identifier = row['Legislature']
      legislature.label = row['LegislatureName']
      
      # We return the legislature object.
      return legislature
    end
  end
end