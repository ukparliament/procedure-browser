module Sparql::Get::StepCollectionWorkPackageCountCurrent

  # A method to get a count of current work packages having actualised steps in a step collection.
  def get_step_collection_work_package_count_current( step_collection_id )
  
    # We get the step collection work package current count query.
    request_body = step_collection_work_package_count_current_query( step_collection_id )
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We take the one and only row from the CSV ...
    csv.take( 1 ).each do |row|
      
      # We return the count.
      return row[0].to_i
    end
  end
end