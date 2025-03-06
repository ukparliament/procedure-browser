module Sparql::Get::EnablingLegislationCount

  # A method to get a count of all enabling legislation.
  def get_enabling_legislation_count
  
    # We get the enabling legislation count query.
    request_body = enabling_legislation_count_query
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We take the one and only row from the CSV ...
    csv.take( 1 ).each do |row|
      
      # We return the count.
      return row[0].to_i
    end
  end
end