module Sparql::Get::OrganisationsAccountableToParliamentAllCreateRecords

  # A method to get an array of all organisations accountable to Parliament.
  def get_organisations_accountable_to_parliament_all

    # We get the all organisations accountable to Parliament query.
    request_body = organisations_accountable_to_parliament_all_query
    
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
  
    # We construct an array to hold the organisations accountable to Parliament.
    organisations_accountable_to_parliament = []
  
    # For each row in the CSV ...
    csv.each do |row|
      start_on = row['startDate'].to_date if row['startDate']
      end_on = row['endDate'].to_date if row['endDate']

      organisation_accountable_to_parliament = OrganisationAccountableToParliament.where(
        identifier: row['Organisations'],
        label: row['Name'],
        start_on: start_on,
        end_on: end_on
      ).first_or_create!

      # ... and add it to the array of organisations accountable to Parliament.
      organisations_accountable_to_parliament << organisation_accountable_to_parliament
    end
  
    # We return the array of organisations accountable to Parliament.
    organisations_accountable_to_parliament
  end
end