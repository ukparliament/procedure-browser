module Sparql::Queries::ProcedureCalculationStyles

  # A SPARQL query to get calculation styles for a procedure.
  def procedure_calculation_styles_query( procedure_id )
    "
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX id: <https://id.parliament.uk/>
      SELECT ?procedureCalculationStyle ?procedureCalculationStyleName WHERE {
        ?Procedure a :Procedure;
                   :name ?ProcedureName.
          ?Procedure :procedureHasCalculationStyle ?procedureCalculationStyle.
    ?procedureCalculationStyle :name ?procedureCalculationStyleName. 
        filter (?Procedure in (id:#{procedure_id}))
              } 
    "
  end
end