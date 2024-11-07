module Sparql::Queries::WorkPackageCount

  # A SPARQL query to get a count of all work packages.
  def work_package_count_query
    "
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX id: <https://id.parliament.uk/>
      select distinct  (COUNT(DISTINCT ?workPackage) AS ?count) where {

       ?Paper a :WorkPackagedThing .  
           ?Paper :name ?Papername ;
           :workPackagedThingHasWorkPackage ?workPackage.
        optional {?Paper :laidThingHasLaying ?laying.
          ?laying :layingDate ?laidDate}
          ?workPackage :workPackageHasProcedure ?procedure.
        ?procedure :name ?procedureName.
       optional { ?workPackage :workPackageHasCalculationStyle ?calculationStyle. 
          ?calculationStyle :name ?calculationStyleName. }
         }    
      
    "
  end
end
