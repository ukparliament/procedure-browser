module Sparql::Queries::WorkPackages

  # A SPARQL query to get all work packages taking parameters of limit and offset.
  def work_packages_query( limit, offset )
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
      } Order by desc (?laidDate)

      LIMIT #{limit} OFFSET #{offset}
    "
  end
end
