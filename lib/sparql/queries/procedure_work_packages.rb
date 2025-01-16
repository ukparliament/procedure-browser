module Sparql::Queries::ProcedureWorkPackages

  # A SPARQL query to get work packages for a procedure.
  def procedure_work_packages_query( procedure_id, limit, offset )
    "
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX id: <https://id.parliament.uk/>
      SELECT distinct * WHERE {
        ?Procedure a :Procedure;
                   :name ?ProcedureName.
           filter (?Procedure in (id:#{procedure_id}))
        ?Procedure :procedureHasWorkPackage ?workPackage.
        ?workPackage :workPackageHasWorkPackagedThing ?workPackagedThing.
        ?workPackagedThing :name ?workPackagedThingName. 
        optional {?workPackage :workPackageHasBusinessItem ?businessItem .
                  ?businessItem :businessItemHasProcedureStep ?step;
                         :businessItemDate ?businessItemDate.
                  filter (?step in (id:isWn7s3K, id:cspzmb6w, id:ITNO9JWr, id:otscOTzB))}
             optional { ?workPackage :workPackageHasCalculationStyle ?calculationStyle. 
                ?calculationStyle :name ?calculationStyleName. }
            }     Order by desc (?businessItemDate)

              LIMIT #{limit} OFFSET #{offset}
    "
  end
end