module Sparql::Get::ProcedureWorkPackageCount

  # A method to get a count of all work packages in a procedure.
  def get_procedure_work_package_count( procedure_id )
  
    # We get the procedure work package count query.
    request_body = procedure_work_package_count_query( procedure_id )
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We take the one and only row from the CSV ...
    csv.take( 1 ).each do |row|
      
      # We return the count.
      return row[0].to_i
    end
  end
end