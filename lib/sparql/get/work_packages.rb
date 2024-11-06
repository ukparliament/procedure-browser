module Sparql::Get::WorkPackages

  # A method to get an array of all work packages on this page with this many results per page.
  def get_work_packages( page_number, results_per_page )
  
    # We calculate the result offset.
    result_offset = ( ( page_number - 1) * results_per_page ) + 1

    # We get the all work packages query passing parameters for the number of results per page and the result offset.
    request_body = work_packages_query( results_per_page, result_offset )
  
    # We get the SPARQL response as a CSV.
    #csv = get_sparql_response_as_csv( request_body )
  
    # We construct an array to hold the work packages.
    work_packages = []
  
    # For each row in the CSV ...
    #csv.each do |row|
  
      # ... we create a new work package object ...
      #work_package = WorkPackage.new
      
      # ... and add it to the array of work packages.
      #work_packages << work_package
    #end
  
    # We return the array of work packages.
    work_packages
  end
end