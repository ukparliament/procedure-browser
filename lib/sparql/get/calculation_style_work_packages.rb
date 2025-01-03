module Sparql::Get::CalculationStyleWorkPackages
  
  def get_calculation_style_work_packages( calculation_style )
    
    # We get the calculation style work packages query.
    request_body = calculation_style_work_packages_query( calculation_style )
    
    # We get the SPARQL response as a CSV.
    #csv = get_sparql_response_as_csv( request_body )
    
    # We construct an array to hold the work packages.
    work_packages = []
  
    # For each row in the CSV ...
    #csv.each do |row|
  
      # ... we create a new work package object ...
      work_package = WorkPackage.new
      																	
      # ... and add it to the array of work packages.
      #work_packages << work_package
    #end
  
    # We return the array of work packages.
    work_packages
  end
end