module Sparql::Queries::TreatyWorkPackages

  # A SPARQL query to get all treaty work packages taking parameters of limit and offset.
  def treaty_work_packages_query( limit, offset )
    "
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
                  PREFIX : <https://id.parliament.uk/schema/>
                  PREFIX id: <https://id.parliament.uk/>
                  SELECT distinct ?Paper ?Papername ?workPackage ?businessItem ?combinedDate ?procedure ?procedure ?procedureName ?calculationStyle ?calculationStyleName (BOUND(?stepId3) AS ?hasCommitteeConcernsFlag)   
      (BOUND(?stepId4) AS ?hasMotionTabledFlag)  where {

                   ?Paper a :Treaty.  
                       ?Paper :name ?Papername ;
                       :workPackagedThingHasWorkPackage ?workPackage.
                   optional {   ?workPackage :workPackageHasBusinessItem ?businessItem .
                     ?businessItem :businessItemHasProcedureStep ?step;
                            :businessItemDate ?businessItemDate.
              filter (?step in (id:isWn7s3K, id:cspzmb6w, id:ITNO9JWr, id:otscOTzB))}
              optional {    ?workPackage :workPackageHasBusinessItem ?businessItem2 .
                     ?businessItem2 :businessItemHasProcedureStep ?step2;
                                    :businessItemDate ?businessItemDate2.
              filter (?step2 in (id:AmYrFxwO))}
                      ?workPackage :workPackageHasProcedure ?procedure.
                    ?procedure :name ?procedureName.
                   optional { ?workPackage :workPackageHasCalculationStyle ?calculationStyle. 
                      ?calculationStyle :name ?calculationStyleName. }
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
          } Order by desc(?combinedDate) ?Papername
          limit #{limit} offset #{offset}
    "
  end
end
