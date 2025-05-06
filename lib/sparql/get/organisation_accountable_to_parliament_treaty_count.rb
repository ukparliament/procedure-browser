module Sparql::Get::OrganisationAccountableToParliamentTreatyCount

  # A method to get a count of all mtreaties lead by an organisation accountable to Parliament.
  def get_organisation_accountable_to_parliament_treaty_count( organisation_accountable_to_parliament_id )
  
    # We get the organisation accountable to Parliament treaty count query.
    request_body = organisation_accountable_to_parliament_treaty_count_query( organisation_accountable_to_parliament_id )
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We take the one and only row from the CSV ...
    csv.take( 1 ).each do |row|
      
      # We return the count.
      return row[0].to_i
    end
  end
end