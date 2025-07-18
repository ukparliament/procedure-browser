module Sparql::Get::ProcedureWorkPackagesCurrent
  
  def get_procedure_work_packages_current( procedure, page_number, results_per_page )
  
    # We calculate the result offset.
    result_offset = ( ( page_number - 1) * results_per_page )
    
    # We get the current procedure work packages query.
    request_body = procedure_work_packages_current_query( procedure, results_per_page, result_offset )
    
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We construct an array to hold the work packages.
    work_packages = []
  
    # For each row in the CSV ...
    csv.each do |row|
  
      # ... we create a new work package object ...
      work_package = WorkPackage.new
      work_package.identifier = row['workPackage']
      work_package.made_available_on = row['combinedDate'].to_date if row['combinedDate']
      work_package.work_packageable_thing_identifer = row['workPackagedThing']
      work_package.work_packageable_thing_label = row['workPackagedThingName']
      work_package.procedure_identifier = row['Procedure']
      work_package.procedure_label = row['ProcedureName']
      work_package.calculation_style_identifier = row['calculationStyle']
      work_package.calculation_style_label = row['calculationStyleName']
      
      # ... and add it to the array of work packages.
      work_packages << work_package
    end
  
    # We return the array of work packages.
    work_packages
  end
end