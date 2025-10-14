module Sparql::Queries::PrimaryLegislationWorkPackageCount

  # A SPARQL query to get a count of all primary legislation work packages.
  def primary_legislation_work_package_count_query
    "
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
        PREFIX : <https://id.parliament.uk/schema/>
        PREFIX id: <https://id.parliament.uk/>
        select distinct  (COUNT(DISTINCT ?workPackage) AS ?count) where {

         ?bill a :PublicBillWork .  
             ?bill  :name ?billName ;
             :workPackagedThingHasWorkPackage ?workPackage.
                    ?workPackage :workPackageHasProcedure ?procedure.
          ?procedure :name ?procedureName.
               }    
    "
  end
end
