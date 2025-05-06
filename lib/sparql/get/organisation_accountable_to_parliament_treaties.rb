module Sparql::Get::OrganisationAccountableToParliamentTreaties
  
  def get_organisation_accountable_to_parliament_treaties( organisation_accountable_to_parliament_id, page_number, results_per_page )
  
    # We calculate the result offset.
    result_offset = ( ( page_number - 1) * results_per_page )
    
    # We get the organisation accountable to parliament treaties query.
    request_body = organisation_accountable_to_parliament_treaties_query( organisation_accountable_to_parliament_id, results_per_page, result_offset )
    
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We construct an array to hold the treaties.
    treaties = []
  
    # For each row in the CSV ...
    csv.each do |row|
  
      # ... we create a new treaty object ...
      treaty = Treaty.new
      treaty.identifier = row['treaty']
      treaty.label = row['TreatyName']
      treaty.laid_on = row['businessItemDate'].to_date
      treaty.series_citation = row['seriesCitation']
      
      # ... and add it to the array of treaies.
      treaties << treaty
    end
  
    # We return the array of treaties.
    treaties
  end
end