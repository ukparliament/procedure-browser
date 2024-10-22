module Sparql::Queries::StepCollection

  # A SPARQL query to get a step collection.
  def step_collection_query( step_collection_id )
    "
      PREFIX id: <https://id.parliament.uk/>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      SELECT ?StepCollection ?stepCollectionName ?procedure ?procedureName ?House ?HouseName  WHERE {

        ?StepCollection a :ProcedureStepCollection;
                  :name ?stepCollectionName.
      optional {?StepCollection :procedureStepCollectionHasProcedure ?procedure.
          ?procedure :name ?procedureName.}
      optional {?StepCollection :procedureStepCollectionHasHouse ?House.
          ?House :name ?HouseName.}
        filter (?StepCollection IN (id:#{step_collection_id}))
      }
    "
  end
end