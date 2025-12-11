module Sparql::Queries::WorkPackagesAll

  # A SPARQL query to get all work packages.
  def work_packages_all_query
    "
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
             PREFIX : <https://id.parliament.uk/schema/>
             PREFIX id: <https://id.parliament.uk/>
             SELECT distinct ?Paper ?Papername ?workPackage ?businessItem ?combinedDate ?procedure ?procedure ?procedureName ?calculationStyle ?calculationStyleName where {
  
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
     BIND(COALESCE(?businessItemDate, ?businessItemDate2) AS ?combinedDate)
     } Order by desc(?combinedDate) ?Papername
   
      "
  end
end
