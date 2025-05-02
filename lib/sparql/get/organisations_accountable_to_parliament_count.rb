module Sparql::Get::OrganisationsAccountableToParliamentCount

  # A method to get a count of all organisations accountable to Parliament.
  def get_organisations_accountable_to_parliament_count
  
    # We get the organisations accountable to Parliament count query.
    request_body = organisations_accountable_to_parliament_count_query
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We take the one and only row from the CSV ...
    csv.take( 1 ).each do |row|
      
      # We return the count.
      return row[0].to_i
    end
  end
end