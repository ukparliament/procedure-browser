module Sparql::Get::WorkPackage

  # A method to get a work package.
  def get_work_package( work_package_id )
  
    # We get the work_package query.
    request_body = work_package_query( work_package_id )
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We take the one and only row from the CSV ...
    csv.take( 1 ).each do |row|
    
      # ... and create a new work package object.
      work_package = WorkPackage.new
      work_package.identifier = row['workPackage']
      work_package.work_packageable_thing_identifer = row['Paper']
      work_package.work_packageable_thing_label = row['Papername']
      work_package.making_available_identifier = row['laying']
      work_package.made_available_on = row['laidDate'].to_date if row['laidDate']
      work_package.procedure_identifier = row['procedure']
      work_package.procedure_label = row['procedureName']
      work_package.calculation_style_identifier = row['calculationStyle']
      work_package.calculation_style_label = row['calculationStyleName']
      
      
      
      
      
      # We return the work package object.
      return work_package
    end
  end
end