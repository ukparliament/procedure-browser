module Sparql::Get::EnablingLegislations

  # A method to get an array of all enabling legislation on this page with this many results per page.
  def get_enabling_legislations( page_number, results_per_page )
  
    # We calculate the result offset.
    result_offset = ( ( page_number - 1) * results_per_page )

    # We get the all enabling legislation query passing parameters for the number of results per page and the result offset.
    request_body = enabling_legislations_query( results_per_page, result_offset )
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
  
    # We construct an array to hold the enabling legislation.
    enabling_legislations = []
  
    # For each row in the CSV ...
    csv.each do |row|
  
      # ... we create a new enabling legislation object ...
      enabling_legislation = EnablingLegislation.new
      enabling_legislation.identifier = row['EnablingThing']
      enabling_legislation.label = row['Name']
      enabling_legislation.date = row['Date'].to_date if row['Date']
      enabling_legislation.year = row['Year']
      enabling_legislation.act_number = row['Number']
      enabling_legislation.uri = row['URL']
      
      # ... and add it to the array of enabling legislation.
      enabling_legislations << enabling_legislation
    end
  
    # We return the array of enabling legislation.
    enabling_legislations
  end
end