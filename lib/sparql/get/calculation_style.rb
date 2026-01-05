module Sparql::Get::CalculationStyle

  # A method to get a calculation style.
  def get_calculation_style( calculation_style_id )
  
    # We get the calculation style query.
    request_body = calculation_style_query( calculation_style_id )
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # If the  calculation style doesn't exist, the csv will be an empty array.
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
end