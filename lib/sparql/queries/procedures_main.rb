module Sparql::Queries::ProceduresMain

  # A SPARQL query to get main procedures.
  def procedures_main_query
    "
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
            PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
            PREFIX : <https://id.parliament.uk/schema/>
            PREFIX id: <https://id.parliament.uk/>
            SELECT * WHERE {
              ?Procedure a :Procedure;
                         :name ?ProcedureName;
                         :procedureDisplayOrder ?ProcedureDisplayOrder.
             ?Procedure :procedureDescription ?ProcedureDescription.
             } Order by ?ProcedureDisplayOrder ?ProcedureName
    "
  end
end