module Sparql::Get::Legislatures

  # A method to get an array of all legislatures.
  def get_legislatures

    # We get the legislatures query.
    request_body = legislatures_query
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
  
    # We construct an array to hold the legislatures.
    legislatures = []
  
    # For each row in the CSV ...
    csv.each do |row|
  
      # ... we create a new legislature object ...
      legislature = Legislature.new
      legislature.identifier = row['Legislature']
      legislature.label = row['LegislatureName']
      
      # ... and add it to the array of legislatures.
      legislatures << legislature
    end
  
    # We return the array of legislatures.
    legislatures
  end
end