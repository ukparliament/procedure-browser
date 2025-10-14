module Sparql::Queries::SecondaryLegislationWorkPackageCount

  # A SPARQL query to get a count of all secondary legislation work packages.
  def secondary_legislation_work_package_count_query
    "
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX id: <https://id.parliament.uk/>
      select distinct  (COUNT(DISTINCT ?workPackage) AS ?count) where {

       ?enabledThing a :EnabledThing .  
           ?enabledThing :name ?enabledThingName ;
           :workPackagedThingHasWorkPackage ?workPackage.
                  ?workPackage :workPackageHasProcedure ?procedure.
        ?procedure :name ?procedureName.
             }    
    "
  end
end
