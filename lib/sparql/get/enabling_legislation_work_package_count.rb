module Sparql::Get::EnablingLegislationWorkPackageCount

  # A method to get a count of all work packages for an item of enabling legislation.
  def get_enabling_legislation_work_package_count( enabling_legislation_id )
  
    # We get the enabling legislation work package count query.
    request_body = enabling_legislation_work_package_count_query( enabling_legislation_id )
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We take the one and only row from the CSV ...
    csv.take( 1 ).each do |row|
      
      # We return the count.
      return row[0].to_i
    end
  end
end