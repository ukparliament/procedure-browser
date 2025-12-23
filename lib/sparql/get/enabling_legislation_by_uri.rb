module Sparql::Get::EnablingLegislationByUri
puts 'purs'

  # A method to get an item of enabling legislation by its legislation.gov.uk URI.
  def get_enabling_legislation_by_uri( enabling_legislation_uri )
  
    # We get the enabling legislation by uri query.
    request_body = enabling_legislation_by_uri_query( enabling_legislation_uri )
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # If the legislation item doesn't exist, the csv will be an empty array.
    # If the array is an empty array ...
    if csv.empty?
      
      # ... we render a 404 ...
      render_404
      
      # ... and return nil.
      return nil
      
    # Otherwise, if the CSV is not an empty array ...
    else
    
      # ... we take the one and only row from the CSV ...
      csv.take( 1 ).each do |row|
    
        # ... and create a new enabling legislation object.
        enabling_legislation = EnablingLegislation.new
        enabling_legislation.identifier = row['Act']
        enabling_legislation.label = row['Name']
        enabling_legislation.date = row['Date'].to_date if row['Date']
        enabling_legislation.year = row['Year']
        enabling_legislation.act_number = row['Number']
        enabling_legislation.uri = row['URL']
        
        # We return the enabling legislation object.
        return enabling_legislation
      end
    end
  end
end