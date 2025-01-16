module Sparql::Get::CalculationStyleWorkPackageCount

  # A method to get a count of all work packages with a given calculation style.
  def get_calculation_style_work_package_count( calculation_style )
  
    # We get the calculation style work package count query.
    request_body = calculation_style_work_package_count_query( calculation_style )
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We take the one and only row from the CSV ...
    csv.take( 1 ).each do |row|
      
      # We return the count.
      return row[0].to_i
    end
  end
end