module Sparql::Get::StepBusinessItemCount

  # A method to get a count of all business items having actualised a step.
  def get_step_business_item_count( step_id )
  
    # We get the step business item count query.
    request_body = step_business_item_count_query( step_id )
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We take the one and only row from the CSV ...
    csv.take( 1 ).each do |row|
      
      # ... and return the count.
      return row[0].to_i
    end
  end
end