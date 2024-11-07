module Sparql::Get::WorkPackageCount

  # A method to get a count of all work packages.
  def get_work_package_count
  
    # We get the work package count query.
    request_body = work_package_count_query
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We take the one and only row from the CSV ...
    csv.take( 1 ).each do |row|
      
      # We return the count.
      return row[0].to_i
    end
  end
end