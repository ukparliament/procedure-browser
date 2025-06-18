module Sparql::Get::WorkPackageableThingCountCurrent

  # A method to get a count of current work packageable things.
  def get_work_packageable_thing_count_current
  
    # We get the work packageable_thing count current query.
    request_body = work_packageable_thing_count_current_query
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We take the one and only row from the CSV ...
    csv.take( 1 ).each do |row|
      
      # We return the count.
      return row[0].to_i
    end
  end
end