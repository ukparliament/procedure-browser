module Sparql::Queries::ProcedureWorkPackagesAll

  # A SPARQL query to get all work packages for a procedure.
  def procedure_work_packages_all_query( procedure_id )
    "
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
           PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
           PREFIX : <https://id.parliament.uk/schema/>
           PREFIX id: <https://id.parliament.uk/>
           SELECT distinct ?Procedure ?ProcedureName ?workPackage ?workPackagedThing ?workPackagedThingName ?combinedDate ?calculationStyle ?calculationStyleName  WHERE {
             ?Procedure a :Procedure;
                        :name ?ProcedureName.
                filter (?Procedure in (id:#{procedure_id}))
             ?Procedure :procedureHasWorkPackage ?workPackage.
             ?workPackage :workPackageHasWorkPackagedThing ?workPackagedThing.
             ?workPackagedThing :name ?workPackagedThingName. 
            optional {   ?workPackage :workPackageHasBusinessItem ?businessItem .
                ?businessItem :businessItemHasProcedureStep ?step;
                       :businessItemDate ?businessItemDate.
         filter (?step in (id:isWn7s3K, id:cspzmb6w, id:ITNO9JWr, id:otscOTzB))}
         optional {    ?workPackage :workPackageHasBusinessItem ?businessItem2 .
                ?businessItem2 :businessItemHasProcedureStep ?step2;
                               :businessItemDate ?businessItemDate2.
         filter (?step2 in (id:AmYrFxwO))}
                  optional { ?workPackage :workPackageHasCalculationStyle ?calculationStyle. 
                     ?calculationStyle :name ?calculationStyleName. }
         BIND(COALESCE(?businessItemDate, ?businessItemDate2) AS ?combinedDate)
     } Order by desc(?combinedDate) ?workPackagedThingName
    "
  end
end