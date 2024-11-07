module Sparql::Get::WorkPackage

  # A method to get a work package.
  def get_work_package( work_package_id )
  
    # We get the work_package query.
    request_body = work_package_query( work_package_id )
  
    # We get the SPARQL response as a CSV.
    #csv = get_sparql_response_as_csv( request_body )
    
    # We take the one and only row from the CSV ...
    #csv.take( 1 ).each do |row|
    
      # ... and create a new work package object.
      #work_package = WorkPackage.new
      
      # We return the work package object.
      #return work_package
    #end
  end
end