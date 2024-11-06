module Sparql::Get::WorkPackageEvents

  # A method to get a work package and its events.
  def get_work_package_events( work_package_id )
  
    # We get the work package events query.
    request_body = work_package_events_query( work_package_id )
  
    # We get the SPARQL response as a CSV.
    #csv = get_sparql_response_as_csv( request_body )
    
    
  end
end