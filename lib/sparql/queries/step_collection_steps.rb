module Sparql::Queries::StepCollectionSteps

  # A SPARQL query to get steps for a step collection.
  def step_collection_steps_query( step_collection_id )
    "
      PREFIX id: <https://id.parliament.uk/>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      SELECT ?StepCollection ?stepCollectionName ?procedure ?procedureName ?House ?HouseName ?StepCollectionMembership ?procedureStep ?procedureStepName ?procedureStepType ?procedureStepTypeName ?procedureSteplegislature ?procedureSteplegislatureName ?procedureStepCommonsId ?procedureStepLordsId  WHERE {

        ?StepCollection a :ProcedureStepCollection;
                  :name ?stepCollectionName.
      optional {?StepCollection :procedureStepCollectionHasProcedure ?procedure.
          ?procedure :name ?procedureName.}
      optional {?StepCollection :procedureStepCollectionHasHouse ?House.
          ?House :name ?HouseName.}
        filter (?StepCollection IN (id:#{step_collection_id}))
       ?StepCollection :procedureStepCollectionHasProcedureStepCollectionMembership ?StepCollectionMembership.
          ?StepCollectionMembership :procedureStepCollectionMembershipHasProcedureStep ?procedureStep.
          ?procedureStep :name ?procedureStepName;
                         :procedureStepHasProcedureStepType ?procedureStepType.
          ?procedureStepType :name ?procedureStepTypeName. 
       optional { ?procedureStep :procedureStepInLegislature ?procedureSteplegislature.
            ?procedureSteplegislature :name ?procedureSteplegislatureName.}
         optional {   ?procedureStep :procedureStepHasHouse ?procedureStepCommonsId.
            filter (?procedureStepCommonsId IN (id:1AFu55Hs))}
          optional{    ?procedureStep :procedureStepHasHouse ?procedureStepLordsId.
            filter (?procedureStepLordsId IN (id:WkUWUBMx))}
      } Order by ?procedureStepName
                     
      
    "
  end
end
