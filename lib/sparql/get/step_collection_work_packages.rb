module Sparql::Get::StepCollectionWorkPackages
  
  def get_step_collection_work_packages( step_collection )
    
    # We get the step collection work packages query.
    request_body = step_collection_work_packages_query( step_collection )
    
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
      work_package.made_available_on = row['MadeAvailableDate'].to_date if row['MadeAvailableDate']
      work_package.procedure_identifier = row['procedure']
      work_package.procedure_label = row['procedureName']
      
      # ... and add it to the array of work packages.
      work_packages << work_package
    end
  
    # We return the array of work_packages.
    work_packages
  end
end