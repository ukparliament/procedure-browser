module Sparql::Get::OrganisationAccountableToParliament

  # A method to get an organisation accountable to Parliament.
  def get_organisation_accountable_to_parliament( organisation_accountable_to_parliament_id )
  
    # We get the organisation accountable to Parliament query.
    request_body = organisation_accountable_to_parliament_query( organisation_accountable_to_parliament_id )
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We take the one and only row from the CSV ...
    csv.take( 1 ).each do |row|
    
      # ... and create a new organisation accountable to Parliament object.
      organisation_accountable_to_parliament = OrganisationAccountableToParliament.new
      organisation_accountable_to_parliament.identifier = row['Organisations']
      organisation_accountable_to_parliament.label = row['Name']
      organisation_accountable_to_parliament.start_on = row['startDate'].to_date if row['startDate']
      organisation_accountable_to_parliament.end_on = row['endDate'].to_date if row['endDate']
      
      # We return the organisation accountable to Parliament object object.
      return organisation_accountable_to_parliament
    end
  end
end