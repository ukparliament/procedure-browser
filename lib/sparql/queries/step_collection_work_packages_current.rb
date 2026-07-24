module Sparql::Queries::StepCollectionWorkPackagesCurrent

  # A SPARQL query to get current work packages for a step collection.
  def step_collection_work_packages_current_query( step_collection_id, limit, offset )
    "
      PREFIX id: <https://id.parliament.uk/>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      SELECT DISTINCT ?workPackage ?workPackagedThing ?workPackagedThingName ?procedure ?procedureName ?combinedDate ?calculationStyle ?calculationStyleName  WHERE {
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
      FILTER NOT EXISTS {?workPackage   :workPackageHasBusinessItem ?bi2.
      ?bi2 :businessItemHasProcedureStep ?stepId2.
      ?stepId2 :procedureStepHasProcedureStepCollectionMembership/:procedureStepCollectionMembershipHasProcedureStepCollection id:TRohjSuI}
      OPTIONAL {?workPackage :workPackageHasBusinessItem ?businessItem1 .
      ?businessItem1 :businessItemHasProcedureStep ?step;
      :businessItemDate ?businessItemDate.
      FILTER (?step in (id:isWn7s3K, id:cspzmb6w, id:ITNO9JWr, id:otscOTzB))}
      OPTIONAL {?workPackage :workPackageHasBusinessItem ?businessItem2 .
      ?businessItem2 :businessItemHasProcedureStep ?step2;
      :businessItemDate ?businessItemDate2.
      FILTER (?step2 in (id:AmYrFxwO))}
      ?workPackage :workPackageHasWorkPackagedThing ?workPackagedThing.
      ?workPackagedThing :name ?workPackagedThingName. 
      ?workPackage :workPackageHasProcedure ?procedure.
      ?procedure :name ?procedureName.
      BIND(COALESCE(?businessItemDate, ?businessItemDate2) AS ?combinedDate)
      OPTIONAL{ ?workPackage :workPackageHasCalculationStyle ?calculationStyle. 
      ?calculationStyle :name ?calculationStyleName. }
      } ORDER BY DESC(?combinedDate) ?workPackagedThingName
      OFFSET #{offset} LIMIT #{limit}
    "
  end
end