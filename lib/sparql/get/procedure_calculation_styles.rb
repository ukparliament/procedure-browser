module Sparql::Get::ProcedureCalculationStyles
  
  def get_procedure_calculation_styles( procedure )
    
    # We get the procedure calculation styles query.
    request_body = procedure_calculation_styles_query( procedure )
    
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We construct an array to hold the calculation styles.
    calculation_styles = []
  
    # For each row in the CSV ...
    csv.each do |row|
  
      # ... we create a new calculation style object ...
      calculation_style = CalculationStyle.new
      calculation_style.identifier = row['procedureCalculationStyle']
      calculation_style.label = row['procedureCalculationStyleName']
      
      # ... and add it to the array of calculation styles.
      calculation_styles << calculation_style
    end
  
    # We return the array of calculation styles.
    calculation_styles
  end
end