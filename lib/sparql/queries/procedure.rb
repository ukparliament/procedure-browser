module Sparql::Queries::Procedure

  # A SPARQL query to get a procedure.
  def procedure_query( procedure_id )
    "
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX id: <https://id.parliament.uk/>
      SELECT * WHERE {
        ?Procedure a :Procedure;
                   :name ?ProcedureName.
        optional {?Procedure :procedureDescription ?ProcedureDescription.}
        optional {?Procedure :procedureHasCalculationStyle ?procedureCalculationStyle.
        ?procedureCalculationStyle :name ?procedureCalculationStyleName. }
        filter (?Procedure in (id:#{procedure_id}))
        optional {?Procedure :startDate ?StartDate.}
        optional {?Procedure :endDate ?EndDate.} 
       } 
    "
  end
end