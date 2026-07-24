module Sparql::Queries::StepCollectionWorkPackageCountCurrent

  # A SPARQL query to get a count of current work packages actualising a step in a step collection.
  def step_collection_work_package_count_current_query( step_collection_id )
    "
      PREFIX id: <https://id.parliament.uk/>
      PREFIX : <https://id.parliament.uk/schema/>
      SELECT DISTINCT  (COUNT(DISTINCT ?workPackage) AS ?count) WHERE  {
      ?stepCollection a :ProcedureStepCollection;
      :name ?stepCollectionName.
      filter (?stepCollection IN (id:#{step_collection_id}))
      ?stepCollection :procedureStepCollectionHasProcedureStepCollectionMembership ?stepCollectionMembership.
      ?stepCollectionMembership :procedureStepCollectionMembershipHasProcedureStep ?procedureStep.
      ?procedureStep :procedureStepHasBusinessItem ?businessItem. 
      ?businessItem :businessItemHasWorkPackage ?workPackage. 
      ?workPackage :workPackageHasWorkPackagedThing ?workPackagedThing;
      :workPackageHasProcedure ?procedure.
      ?workPackagedThing :name ?workPackagedThingName. 
      ?procedure :name ?procedureName.
      FILTER NOT EXISTS {
      ?workPackage :workPackageHasBusinessItem ?bi2 .
      ?bi2 :businessItemHasProcedureStep ?stepId2 .
      ?stepId2 :procedureStepHasProcedureStepCollectionMembership/:procedureStepCollectionMembershipHasProcedureStepCollection id:TRohjSuI .
      }
      OPTIONAL {?workPackage :workPackageHasBusinessItem ?businessItem2 .
      ?businessItem2 :businessItemHasProcedureStep ?step2;
      :businessItemDate ?MadeAvailableDate.
      FILTER (?step2 in (id:isWn7s3K, id:cspzmb6w, id:ITNO9JWr, id:otscOTzB))}
      }
    "
  end
end
