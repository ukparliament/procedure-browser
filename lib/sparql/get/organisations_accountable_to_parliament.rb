module Sparql::Get::OrganisationsAccountableToParliament

  # A method to get an array of all organisations accountable to Parliament on this page with this many results per page.
  def get_organisations_accountable_to_parliament( page_number, results_per_page )
  
    # We calculate the result offset.
    result_offset = ( ( page_number - 1) * results_per_page )

    # We get the all organisations accountable to Parliament query passing parameters for the number of results per page and the result offset.
    request_body = organisations_accountable_to_parliament_query( results_per_page, result_offset )
    
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
  
    # We construct an array to hold the organisations accountable to Parliament.
    organisations_accountable_to_parliament = []
  
    # For each row in the CSV ...
    csv.each do |row|
  
      # ... we create a new organisation accountable to Parliament object ...
      organisation_accountable_to_parliament = OrganisationAccountableToParliament.new
      organisation_accountable_to_parliament.identifier = row['Organisations']
      organisation_accountable_to_parliament.label = row['Name']
      organisation_accountable_to_parliament.start_on = row['startDate'].to_date if row['startDate']
      organisation_accountable_to_parliament.end_on = row['endDate'].to_date if row['endDate']
      
      # ... and add it to the array of organisations accountable to Parliament.
      organisations_accountable_to_parliament << organisation_accountable_to_parliament
    end
  
    # We return the array of organisations accountable to Parliament.
    organisations_accountable_to_parliament
  end
end