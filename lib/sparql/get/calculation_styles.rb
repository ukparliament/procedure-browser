module Sparql::Get::CalculationStyles

  # A method to get an array of all calculation styles.
  def get_calculation_styles

    # We get the all calculation styles query.
    request_body = calculation_styles_query
  
    # We get the SPARQL response as a CSV.
    #csv = get_sparql_response_as_csv( request_body )
  
    # We construct an array to hold the calculation styles.
    calculation_styles = []
  
    # For each row in the CSV ...
    #csv.each do |row|
  
      # ... we create a new calculation style object ...
      #calculation_style = CalculationStyle.new
      
      # ... and add it to the array of steps.
      #calculation_styles << calculation_style
    #end
  
    # We return the array of calculation styles.
    calculation_styles
  end
end