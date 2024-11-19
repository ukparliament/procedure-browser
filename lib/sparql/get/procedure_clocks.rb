module Sparql::Get::ProcedureClocks
  
  def get_procedure_clocks( procedure )
    
    # We get the procedure clocks query.
    request_body = procedure_clocks_query( procedure )
    
    # We get the SPARQL response as a CSV.
    #csv = get_sparql_response_as_csv( request_body )
    
    # We construct an array to hold the clocks.
    clocks = []
  
    # For each row in the CSV ...
    #csv.each do |row|
  
      # ... we create a new clock object ...
      #clock = Clock.new
      
      # ... and add it to the array of routes.
      #clocks << clock
    #end
  
    # We return the array of clocks.
    clocks
  end
end