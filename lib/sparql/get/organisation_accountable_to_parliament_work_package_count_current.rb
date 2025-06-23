module Sparql::Get::OrganisationAccountableToParliamentWorkPackageCountCurrent

  # A method to get a count of current work packages for an organisation accountable to Parliament.
  def get_organisation_accountable_to_parliament_work_package_current_count( organisation_accountable_to_parliament_id )
  
    # We get the organisation accountable to Parliament current work package count query.
    request_body = organisation_accountable_to_parliament_work_package_count_current_query( organisation_accountable_to_parliament_id )
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We take the one and only row from the CSV ...
    csv.take( 1 ).each do |row|
      
      # We return the count.
      return row[0].to_i
    end
  end
end