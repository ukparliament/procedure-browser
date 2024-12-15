module Sparql::Get::Clock

  # A method to get a clock.
  def get_clock( clock_id )
  
    # We get the clock query.
    request_body = clock_query( clock_id )
  
    # We get the SPARQL response as a CSV.
    #csv = get_sparql_response_as_csv( request_body )
    
    # We take the one and only row from the CSV ...
    #csv.take( 1 ).each do |row|
    
      # ... and create a new clock object.
      clock = Clock.new
      
      # We return the clock object.
      return clock
    #end
  end
end