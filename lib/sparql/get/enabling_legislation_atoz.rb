module Sparql::Get::EnablingLegislationAtoz

  # A method to get an A to Z of enabling legislation.
  def get_enabling_legislation_atoz
  
    # We get the enabling legislation A to Zquery.
    request_body = enabling_legislation_atoz_query
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
  
    # We construct an array to hold the letters.
    letters = []
  
    # For each row in the CSV ...
    csv.each do |row|
    
      # ... we create a new letter object.
      letter = Letter.new
      letter.letter = row['FirstLetter']
      letter.count = row['Count']
      
      # ... and add it to the array of letters.
      letters << letter
    end
  
    # We return the array of letters.
    letters
  end
end