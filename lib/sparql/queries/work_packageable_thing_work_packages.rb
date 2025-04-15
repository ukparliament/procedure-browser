module Sparql::Queries::WorkPackageableThingWorkPackages

  # A SPARQL query to get a list of all work packages for a work packageable thing.
  def work_packageable_thing_work_packages_query( work_packageable_thing_id )
    "
      PREFIX id: <https://id.parliament.uk/>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      select ?workPackage ?WorkPackagedThing ?workPackagedThingName ?MadeAvailableDate ?procedure ?procedureName where {
        ?WorkPackagedThing a :WorkPackagedThing;
                           :name ?workPackagedThingName;
                           :workPackagedThingHasWorkPackage ?workPackage.
        ?workPackage :workPackageHasProcedure ?procedure.
        ?procedure :name ?procedureName. 
        optional {?workPackage :workPackageHasBusinessItem ?businessItem .
                  ?businessItem :businessItemHasProcedureStep ?step;
                         :businessItemDate ?MadeAvailableDate.
                  filter (?step in (id:isWn7s3K, id:cspzmb6w, id:ITNO9JWr, id:otscOTzB))}
        filter (?WorkPackagedThing in (id:#{work_packageable_thing_id}))
  
      }
    "
  end
end



