module Sparql::Queries::StepCollectionWorkPackages

  # A SPARQL query to get work packages for a step collection.
  def step_collection_work_packages_query( step_collection_id )
    "
      PREFIX id: <https://id.parliament.uk/>
          PREFIX : <https://id.parliament.uk/schema/>
          PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
          PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
          SELECT  ?procedureStep ?procedureStepName ?businessItem ?businessItemDate ?businessItemLink ?workPackage ?workPackagedThing ?workPackagedThingName ?procedure ?procedureName ?MadeAvailableDate  WHERE {

            ?StepCollection a :ProcedureStepCollection;
                      :name ?stepCollectionName.
                 filter (?StepCollection IN (id:#{step_collection_id}))
           ?StepCollection :procedureStepCollectionHasProcedureStepCollectionMembership ?StepCollectionMembership.
              ?StepCollectionMembership :procedureStepCollectionMembershipHasProcedureStep ?procedureStep.
              ?procedureStep :name ?procedureStepName.     
    
      ?procedureStep :procedureStepHasBusinessItem ?businessItem. 
      ?businessItem :businessItemHasWorkPackage ?workPackage. 
        ?workPackage :workPackageHasWorkPackagedThing ?workPackagedThing;
                     :workPackageHasProcedure ?procedure.
        ?workPackagedThing :name ?workPackagedThingName. 
      	?procedure :name ?procedureName.
      optional { ?businessItem :businessItemDate ?businessItemDate.}
      optional {?businessItem :businessItemHasBusinessItemWebLink ?businessItemLink.}
      optional {?workPackage :workPackageHasBusinessItem ?businessItem2 .
                ?businessItem2 :businessItemHasProcedureStep ?step2;
                       :businessItemDate ?MadeAvailableDate.
                filter (?step2 in (id:isWn7s3K, id:cspzmb6w, id:ITNO9JWr, id:otscOTzB))}
  
                } Order by desc(?businessItemDate) ?procedureStepName ?MadeAvailableDate
    "
  end
end