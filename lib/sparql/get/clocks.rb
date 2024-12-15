module Sparql::Get::Clocks

  # A method to get an array of all clocks.
  def get_clocks

    # We get the clocks query.
    request_body = clocks_query
  
    # We get the SPARQL response as a CSV.
    #csv = get_sparql_response_as_csv( request_body )
  
    # We construct an array to hold the clocks.
    clocks = []
  
    # For each row in the CSV ...
    #csv.each do |row|
  
      # ... we create a new clock object ...
      clock = Clock.new
      
      # ... and add it to the array of clocks.
      clocks << clock
    #end
  
    # We return the array of clocks.
    clocks
  end
end