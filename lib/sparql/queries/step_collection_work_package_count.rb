module Sparql::Queries::StepCollectionWorkPackageCount

  # A SPARQL query to get a count of all work packages actualising a step in a step collection.
  def step_collection_work_package_count_query( step_collection_id )
    "
      PREFIX id: <https://id.parliament.uk/>
          PREFIX : <https://id.parliament.uk/schema/>
          PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
          PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
          select distinct  (COUNT(DISTINCT ?workPackage) AS ?count) where  {

            ?StepCollection a :ProcedureStepCollection;
                      :name ?stepCollectionName.
                 filter (?StepCollection IN (id:#{step_collection_id}))
           ?StepCollection :procedureStepCollectionHasProcedureStepCollectionMembership ?StepCollectionMembership.
              ?StepCollectionMembership :procedureStepCollectionMembershipHasProcedureStep ?procedureStep.
    
      ?procedureStep :procedureStepHasBusinessItem ?businessItem. 
      ?businessItem :businessItemHasWorkPackage ?workPackage. 
        ?workPackage :workPackageHasWorkPackagedThing ?workPackagedThing;
                     :workPackageHasProcedure ?procedure.
        ?workPackagedThing :name ?workPackagedThingName. 
      	?procedure :name ?procedureName.
      optional {?workPackage :workPackageHasBusinessItem ?businessItem2 .
                ?businessItem2 :businessItemHasProcedureStep ?step2;
                       :businessItemDate ?MadeAvailableDate.
                filter (?step2 in (id:isWn7s3K, id:cspzmb6w, id:ITNO9JWr, id:otscOTzB))}
  
      } 
    "
  end
end
