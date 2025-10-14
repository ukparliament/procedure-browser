module Sparql::Queries::TreatyWorkPackageCount

  # A SPARQL query to get a count of all treaty work packages.
  def treaty_work_package_count_query
    "
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX id: <https://id.parliament.uk/>
      select distinct  (COUNT(DISTINCT ?workPackage) AS ?count) where {

       ?treaty a :Treaty .  
           ?treaty  :name ?treatyName ;
           :workPackagedThingHasWorkPackage ?workPackage.
                  ?workPackage :workPackageHasProcedure ?procedure.
        ?procedure :name ?procedureName.
             }    
    "
  end
end
