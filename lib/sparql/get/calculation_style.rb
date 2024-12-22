module Sparql::Get::CalculationStyle

  # A method to get a calculation style.
  def get_calculation_style( calculation_style_id )
  
    # We get the calculation style query.
    request_body = calculation_style_query( calculation_style_id )
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We take the one and only row from the CSV ...
    csv.take( 1 ).each do |row|
    
      # ... and create a new calculation style object.
      calculation_style = CalculationStyle.new
      calculation_style.identifier = row['CalculationStyle']
      calculation_style.label = row['CalculationStyleName']
      calculation_style.egg_timer_id = row['eggTimerId']
      
      # We return the calculation style object.
      return calculation_style
    end
  end
end