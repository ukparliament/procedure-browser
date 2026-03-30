module Sparql::Queries::ProcedureWorkPackagesCurrent

  # A SPARQL query to get current work packages for a procedure.
  def procedure_work_packages_current_query( procedure_id, limit, offset )
    "
    PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
               PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
               PREFIX : <https://id.parliament.uk/schema/>
               PREFIX id: <https://id.parliament.uk/>
               SELECT distinct ?Procedure ?ProcedureName ?workPackage ?workPackagedThing ?workPackagedThingName ?combinedDate ?calculationStyle ?calculationStyleName (BOUND(?stepId3) AS ?hasCommitteeConcernsFlag)   
      (BOUND(?stepId4) AS ?hasMotionTabledFlag) WHERE {
                 ?Procedure a :Procedure;
                            :name ?ProcedureName.
                    filter (?Procedure in (id:#{procedure_id}))
                 ?Procedure :procedureHasWorkPackage ?workPackage.
                 ?workPackage :workPackageHasWorkPackagedThing ?workPackagedThing.
                 ?workPackagedThing :name ?workPackagedThingName. 
                optional {   ?workPackage :workPackageHasBusinessItem ?businessItem .
                    ?businessItem :businessItemHasProcedureStep ?step;
                           :businessItemDate ?businessItemDate.
             filter (?step in (id:isWn7s3K, id:cspzmb6w, id:ITNO9JWr, id:otscOTzB))}
             optional {    ?workPackage :workPackageHasBusinessItem ?businessItem2 .
                    ?businessItem2 :businessItemHasProcedureStep ?step2;
                                   :businessItemDate ?businessItemDate2.
             filter (?step2 in (id:AmYrFxwO))}
                      optional { ?workPackage :workPackageHasCalculationStyle ?calculationStyle. 
                         ?calculationStyle :name ?calculationStyleName. }
            MINUS {  ?workPackage   :workPackageHasBusinessItem ?bi2.
                ?bi2 :businessItemHasProcedureStep ?stepId2.
                   ?stepId2 :procedureStepHasProcedureStepCollectionMembership/:procedureStepCollectionMembershipHasProcedureStepCollection id:TRohjSuI}
        OPTIONAL {
         ?workPackage :workPackageHasBusinessItem ?bi3 .
         ?bi3 :businessItemHasProcedureStep ?stepId3 .
         ?stepId3 :procedureStepHasProcedureStepCollectionMembership/
                  :procedureStepCollectionMembershipHasProcedureStepCollection id:7CBVQcZF
       }
 
         OPTIONAL {
         ?workPackage :workPackageHasBusinessItem ?bi4 .
         ?bi4 :businessItemHasProcedureStep ?stepId4 .
         ?stepId4 :procedureStepHasProcedureStepCollectionMembership/
                  :procedureStepCollectionMembershipHasProcedureStepCollection id:l3g2umNB
       }
              BIND(COALESCE(?businessItemDate, ?businessItemDate2) AS ?combinedDate)
         } Order by desc(?combinedDate) ?workPackagedThingName
         limit #{limit} offset #{offset}
    
    "
  end
end