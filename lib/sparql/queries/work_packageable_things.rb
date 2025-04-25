module Sparql::Queries::WorkPackageableThings

  # A SPARQL query to get all work packageable things taking parameters of limit and offset.
  def work_packageable_things_query( limit, offset )
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
            
              } Order by desc (?businessItemDate)
      LIMIT #{limit} OFFSET #{offset}
    "
  end
end
