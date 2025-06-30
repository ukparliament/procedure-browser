module Sparql::Get::OrganisationAccountableToParliamentTreatyWorkPackages
  
  def get_organisation_accountable_to_parliament_treaty_work_packages( organisation_accountable_to_parliament_id, page_number, results_per_page )
  
    # We calculate the result offset.
    result_offset = ( ( page_number - 1) * results_per_page )
    
    # We get the organisation accountable to parliament treaty work packages query.
    request_body = organisation_accountable_to_parliament_treaty_work_packages_query( organisation_accountable_to_parliament_id, results_per_page, result_offset )
    
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We construct an array to hold the work packages.
    work_packages = []
  
    # For each row in the CSV ...
    csv.each do |row|
  
      # ... we create a new work package object ...
      work_package = WorkPackage.new
      work_package.identifier = row['WorkPackage']
      work_package.work_packageable_thing_identifer = row['treaty']
      work_package.work_packageable_thing_label = row['TreatyName']
      work_package.made_available_on = row['businessItemDate'].to_date if row['businessItemDate']
      
      
      # TODO: waiting on new query
      work_package.procedure_identifier = 'beep'
      work_package.procedure_label = 'boop'
      
      
      
      work_package.calculation_style_identifier = row['calculationStyle']
      work_package.calculation_style_label = row['calculationStyleName']
      
      # ... and add it to the array of work packages.
      work_packages << work_package
    end
  
    # We return the array of work packages.
    work_packages
  end
end