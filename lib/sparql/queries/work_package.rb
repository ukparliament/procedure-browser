module Sparql::Queries::WorkPackage

  # A SPARQL query to get a work package.
  def work_package_query( work_package_id )
    "
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX id: <https://id.parliament.uk/>
      SELECT * where {
  
       ?Paper a :WorkPackagedThing .  
           ?Paper :name ?Papername ;
           :workPackagedThingHasWorkPackage ?workPackage.
         optional {?Paper :laidThingHasLaying ?laying.
          ?laying :layingDate ?laidDate;
                  :businessItemHasProcedureStep ?step.
          filter (?step in (id:isWn7s3K, id:cspzmb6w))}
          ?workPackage :workPackageHasProcedure ?procedure.
        ?procedure :name ?procedureName.
       optional { ?workPackage :workPackageHasCalculationStyle ?calculationStyle. 
          ?calculationStyle :name ?calculationStyleName. }
        filter (?workPackage in (id:#{work_package_id}))
      } 
    "
  end
end