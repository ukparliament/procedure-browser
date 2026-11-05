module Sparql::Get::ProceduresComponent

  # A method to get an array of component procedures.
  def get_component_procedures

    # We get the component procedure query.
    request_body = procedures_component_query
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
  
    # We construct an array to hold the procedures.
    procedures = []
  
    # For each row in the CSV ...
    csv.each do |row|
  
      # ... we create a new procedure object ...
      procedure = Procedure.new
      procedure.identifier = row['Procedure']
      procedure.label = row['ProcedureName']
      procedure.description = row['ProcedureDescription']
      procedure.display_order = row['ProcedureDisplayOrder']
      
      # ... and add it to the array of procedures.
      procedures << procedure
    end
  
    # We return the array of procedures.
    procedures
  end
end