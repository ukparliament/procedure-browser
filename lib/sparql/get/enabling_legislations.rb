module Sparql::Get::EnablingLegislations

  # A method to get an array of all enabling legislation on this page with this many results per page.
  def get_enabling_legislations

    # We get the all enabling legislation query.
    request_body = enabling_legislations_query
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
  
    # We construct an array to hold the enabling legislation.
    enabling_legislations = []
  
    # For each row in the CSV ...
    csv.each do |row|
  
      # ... we create a new enabling legislation object ...
      enabling_legislation = EnablingLegislation.new
      enabling_legislation.identifier = row['enablingThing']
      enabling_legislation.label = row['name']
      enabling_legislation.date = row['date'].to_date if row['date']
      enabling_legislation.year = row['year']
      enabling_legislation.act_number = row['number']
      enabling_legislation.uri = row['url']
      
      # ... and add it to the array of enabling legislation.
      enabling_legislations << enabling_legislation
    end
  
    # We return the array of enabling legislation.
    enabling_legislations
  end
end