module Sparql::Get::EnablingLegislation

  # A method to get an item of enabling legislation.
  def get_enabling_legislation( enabling_legislation_id )
  
    # We get the enabling legislation query.
    request_body = enabling_legislation_query( enabling_legislation_id )
  
    # We get the SPARQL response as a CSV.
    #csv = get_sparql_response_as_csv( request_body )
    
    # We take the one and only row from the CSV ...
    #csv.take( 1 ).each do |row|
    
      # ... and create a new enabling legislation object.
      #enabling_legislation = EnablingLegislation.new
      
      # We return the enabling legislation object.
      #return enabling_legislation
    #end
  end
end