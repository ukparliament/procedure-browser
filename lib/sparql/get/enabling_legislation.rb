module Sparql::Get::EnablingLegislation

  # A method to get an item of enabling legislation.
  def get_enabling_legislation( enabling_legislation_id )
  
    # We get the enabling legislation query.
    request_body = enabling_legislation_query( enabling_legislation_id )
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # If the enabling legislation doesn't exist, the csv will be an empty array.
    # If the array is an empty array ...
    if csv.empty?
      
      # ... we render a 404 ...
      render_404
      
      # ... and return nil.
      return nil
      
    # Otherwise, if the CSV is not an empty array ...
    else
    
      # We take the one and only row from the CSV ...
      csv.take( 1 ).each do |row|
    
        # ... and create a new enabling legislation object.
        enabling_legislation = EnablingLegislation.new
        enabling_legislation.identifier = row['act']
        enabling_legislation.label = row['name']
        enabling_legislation.date = row['date'].to_date if row['date']
        enabling_legislation.year = row['year']
        enabling_legislation.act_number = row['number']
        enabling_legislation.uri = row['url']
      
        # We return the enabling legislation object.
        return enabling_legislation
      end
    end
  end
end