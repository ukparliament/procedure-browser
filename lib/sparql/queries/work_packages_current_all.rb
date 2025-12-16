module Sparql::Queries::WorkPackagesCurrentAll

  # A SPARQL query to get current work package.
  def work_packages_current_all_query
    "
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
             PREFIX : <https://id.parliament.uk/schema/>
             PREFIX id: <https://id.parliament.uk/>
              SELECT ?Paper ?Papername ?workPackage ?businessItem ?step ?combinedDate ?procedure ?procedureName ?calculationStyle ?calculationStyleName where {

  
              ?Paper a :WorkPackagedThing .  
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
        MINUS {  ?workPackage   :workPackageHasBusinessItem ?bi2.
       ?bi2 :businessItemHasProcedureStep ?stepId2.
          ?stepId2 :procedureStepHasProcedureStepCollectionMembership/:procedureStepCollectionMembershipHasProcedureStepCollection id:TRohjSuI}
     BIND(COALESCE(?businessItemDate, ?businessItemDate2) AS ?combinedDate)
     } Order by desc(?combinedDate) ?Papername
    "
  end
end
