module Sparql::Queries::WorkPackageableThingCountCurrent

  # A SPARQL query to get a count of current work packageable things.
  def work_packageable_thing_count_current_query
    "
      PREFIX id: <https://id.parliament.uk/>
            PREFIX : <https://id.parliament.uk/schema/>
            PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
            PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
            select (COUNT(DISTINCT ?WorkPackagedThing) AS ?count)  where {
              ?WorkPackagedThing a :WorkPackagedThing;
                                 :name ?workPackagedThingName.
        ?WorkPackagedThing :workPackagedThingHasWorkPackage ?workPackage.
          MINUS {  ?workPackage   :workPackageHasBusinessItem ?bi2.
        ?bi2 :businessItemHasProcedureStep ?stepId2.
           ?stepId2 :procedureStepHasProcedureStepCollectionMembership/:procedureStepCollectionMembershipHasProcedureStepCollection id:TRohjSuI}
            }
    "
  end
end
