module Sparql::Get::StepCollectionWorkPackagesCurrent
  
  def get_step_collection_work_packages_current( step_collection, page_number, results_per_page )
  
    # We calculate the result offset.
    result_offset = ( ( page_number - 1) * results_per_page )
    
    # We get the current step collection work packages query.
    request_body = step_collection_work_packages_current_query( step_collection, results_per_page, result_offset )
    
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We construct an array to hold the work packages.
    work_packages = []
  
    # For each row in the CSV ...
    csv.each do |row|
  
      # ... we create a new work package object ...
      work_package = WorkPackage.new
      work_package.identifier = row['workPackage']
      work_package.work_packageable_thing_identifer = row['workPackagedThing']
      work_package.work_packageable_thing_label = row['workPackagedThingName']
      work_package.made_available_on = row['combinedDate'].to_date if row['combinedDate']
      work_package.procedure_identifier = row['procedure']
      work_package.procedure_label = row['procedureName']
      
      # ... and add it to the array of work packages.
      work_packages << work_package
    end
  
    # We return the array of work_packages.
    work_packages
  end
end