module Sparql::Get::EnablingLegislationAtozLetter

  # A method to get a list of enabling legislation starting with a given letter.
  def get_enabling_legislation_atoz_letter( letter )
  
    # We get the enabling legislation A-Z letter query.
    request_body = enabling_legislation_atoz_letter_query( letter )
  
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