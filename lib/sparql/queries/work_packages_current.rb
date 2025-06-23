module Sparql::Queries::WorkPackagesCurrent

  # A SPARQL query to get current work packages taking parameters of limit and offset.
  def work_packages_current_query( limit, offset )
    "
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
             PREFIX : <https://id.parliament.uk/schema/>
             PREFIX id: <https://id.parliament.uk/>
             SELECT * where {
  
              ?Paper a :WorkPackagedThing .  
                  ?Paper :name ?Papername ;
                  :workPackagedThingHasWorkPackage ?workPackage.
               optional {?workPackage :workPackageHasBusinessItem ?businessItem .
                 ?businessItem :businessItemHasProcedureStep ?step;
                        :businessItemDate ?businessItemDate.
                 filter (?step in (id:isWn7s3K, id:cspzmb6w, id:ITNO9JWr, id:otscOTzB))}
                 ?workPackage :workPackageHasProcedure ?procedure.
               ?procedure :name ?procedureName.
              optional { ?workPackage :workPackageHasCalculationStyle ?calculationStyle. 
                 ?calculationStyle :name ?calculationStyleName. }
        MINUS {  ?workPackage   :workPackageHasBusinessItem ?bi2.
       ?bi2 :businessItemHasProcedureStep ?stepId2.
          ?stepId2 :procedureStepHasProcedureStepCollectionMembership/:procedureStepCollectionMembershipHasProcedureStepCollection id:TRohjSuI}
             } Order by desc (?businessItemDate)

             LIMIT #{limit} OFFSET #{offset}
    "
  end
end
