module Sparql::Queries::WorkPackageableThingsCurrent

  # A SPARQL query to get current work packageable things taking parameters of limit and offset.
  def work_packageable_things_current_query( limit, offset )
    "
      PREFIX id: <https://id.parliament.uk/>
            PREFIX : <https://id.parliament.uk/schema/>
            PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
            PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
            select ?WorkPackagedThing ?workPackagedThingName where {
              ?WorkPackagedThing a :WorkPackagedThing;
                                 :name ?workPackagedThingName.
              ?WorkPackagedThing :workPackagedThingHasWorkPackage ?workPackage.
              optional {?workPackage :workPackageHasBusinessItem ?businessItem .
                        ?businessItem :businessItemHasProcedureStep ?step;
                               :businessItemDate ?businessItemDate.
                        filter (?step in (id:isWn7s3K, id:cspzmb6w, id:ITNO9JWr, id:otscOTzB))}
                  MINUS {  ?workPackage   :workPackageHasBusinessItem ?bi2.
        ?bi2 :businessItemHasProcedureStep ?stepId2.
           ?stepId2 :procedureStepHasProcedureStepCollectionMembership/:procedureStepCollectionMembershipHasProcedureStepCollection id:TRohjSuI}
                    } Order by desc (?businessItemDate)
            LIMIT #{limit} OFFSET #{offset}
    "
  end
end
