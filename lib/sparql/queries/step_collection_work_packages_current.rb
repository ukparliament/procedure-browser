module Sparql::Queries::StepCollectionWorkPackagesCurrent

  # A SPARQL query to get current work packages for a step collection.
  def step_collection_work_packages_current_query( step_collection_id, limit, offset )
    "
    PREFIX id: <https://id.parliament.uk/>
                        PREFIX : <https://id.parliament.uk/schema/>
                        PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
                        PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
                        SELECT distinct ?workPackage ?workPackagedThing ?workPackagedThingName ?procedure ?procedureName ?combinedDate ?calculationStyle ?calculationStyleName  WHERE {

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
                    	?procedure :name ?procedureName.  MINUS {  ?workPackage   :workPackageHasBusinessItem ?bi2.
                ?bi2 :businessItemHasProcedureStep ?stepId2.
                   ?stepId2 :procedureStepHasProcedureStepCollectionMembership/:procedureStepCollectionMembershipHasProcedureStepCollection id:TRohjSuI}
                       optional {   ?workPackage :workPackageHasBusinessItem ?businessItem1 .
                  ?businessItem1 :businessItemHasProcedureStep ?step;
                         :businessItemDate ?businessItemDate.
           filter (?step in (id:isWn7s3K, id:cspzmb6w, id:ITNO9JWr, id:otscOTzB))}
         optional {    ?workPackage :workPackageHasBusinessItem ?businessItem2 .
                  ?businessItem2 :businessItemHasProcedureStep ?step2;
                                 :businessItemDate ?businessItemDate2.
           filter (?step2 in (id:AmYrFxwO))}
         			?workPackage :workPackageHasWorkPackagedThing ?workPackagedThing.
         			?workPackagedThing :name ?workPackagedThingName. 
                   ?workPackage :workPackageHasProcedure ?procedure.
                 ?procedure :name ?procedureName.
          BIND(COALESCE(?businessItemDate, ?businessItemDate2) AS ?combinedDate)
   optional { ?workPackage :workPackageHasCalculationStyle ?calculationStyle. 
                  ?calculationStyle :name ?calculationStyleName. }
        } Order by desc(?combinedDate) ?workPackagedThingName
                            offset #{offset} limit #{limit}
                     
    
    "
  end
end