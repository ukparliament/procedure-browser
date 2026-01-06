module Sparql::Get::CalculationStyleWorkPackagesAll
  
  def get_calculation_style_work_packages_all( calculation_style )
    
    # We get the calculation style work packages query.
    request_body = calculation_style_work_packages_all_query( calculation_style )
    
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We construct an array to hold the work packages.
    work_packages = []
  
    # For each row in the CSV ...
    csv.each do |row|
  
      # ... we create a new work package object ...
      work_package = WorkPackage.new
      work_package.identifier = row['workPackage']
      work_package.calculation_style_label = row['CalculationStyleName']
      work_package.work_packageable_thing_identifer = row['workPackagedThing']
      work_package.work_packageable_thing_label = row['workPackagedThingName']
      work_package.procedure_identifier = row['procedure']
      work_package.procedure_label = row['procedureName']
      work_package.made_available_on = row['combinedDate'].to_date if row['combinedDate']
      																	
      # ... and add it to the array of work packages.
      work_packages << work_package
    end
  
    # We return the array of work packages.
    work_packages
  end
end