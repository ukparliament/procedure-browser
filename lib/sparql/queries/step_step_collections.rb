module STEP_STEP_COLLECTIONS_QUERY

  Sparql::Queries::StepStepCollections = true

  # A SPARQL query to get all step collections for a step.
  def step_step_collections_query( step_id )
    "
      PREFIX id: <https://id.parliament.uk/>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      SELECT  ?stepCollectionMembership ?stepCollection ?stepCollectionLabel ?procedure ?procedureName ?House ?HouseName  WHERE {

        ?Step a :ProcedureStep;
                  :name ?stepName;
                  :procedureStepHasProcedureStepType ?stepType;
            :procedureStepHasProcedureStepCollectionMembership ?stepCollectionMembership.
          ?stepType :name ?stepTypeLabel.
        ?stepCollectionMembership :procedureStepCollectionMembershipHasProcedureStepCollection ?stepCollection.
        ?stepCollection :name ?stepCollectionLabel.
        optional {?stepCollection :procedureStepCollectionHasProcedure ?procedure.
          ?procedure :name ?procedureName}
        optional {?stepCollection :procedureStepCollectionHasHouse ?House.
          ?House :name ?HouseName.}
        filter (?Step IN (id:#{step_id}))}
      order by ?stepCollectionLabel
    "
  end
end