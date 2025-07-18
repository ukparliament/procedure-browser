module Sparql::Get::WorkPackageableThingWorkPackages
  
  # A method to get an array of all work packages for a work packageable thing.
  def get_work_packageable_thing_work_packages( work_packageable_thing_id )
  
    # We get the work packageable thing work packages query.
    request_body = work_packageable_thing_work_packages_query( work_packageable_thing_id )
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
  
    # We construct an array to hold the work packages.
    work_packages = []
  
    # For each row in the CSV ...
    csv.each do |row|
  
      # ... we create a new work package object ...
      work_package = WorkPackage.new
      work_package.identifier = row['workPackage']
      work_package.work_packageable_thing_identifer = row['WorkPackagedThing']
      work_package.work_packageable_thing_label = row['workPackagedThingName']
      work_package.made_available_on = row['combinedDate'].to_date if row['combinedDate']
      work_package.procedure_identifier = row['procedure']
      work_package.procedure_label = row['procedureName']
      
      # ... and add it to the array of work packages.
      work_packages << work_package
    end
  
    # We return the array of work packages.
    work_packages
  end
end