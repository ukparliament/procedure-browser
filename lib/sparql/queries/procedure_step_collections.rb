module Sparql::Queries::ProcedureStepCollections

  # A SPARQL query to get step collections for a procedure.
  def procedure_step_collections_query( procedure_id )
    "
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX id: <https://id.parliament.uk/>
      SELECT * WHERE {
        ?Procedure a :Procedure;
                   :name ?ProcedureName.
         filter (?Procedure in (id:#{procedure_id}))
         ?Procedure :procedureHasProcedureStepCollection ?stepCollection.
        ?stepCollection :name ?stepCollectionLabel. 
       }
    "
  end
end