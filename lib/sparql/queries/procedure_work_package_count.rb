module Sparql::Queries::ProcedureWorkPackageCount

  # A SPARQL query to get a count of all work packages in a procedure.
  def procedure_work_package_count_query( procedure_id )
    "
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX id: <https://id.parliament.uk/>
      SELECT distinct (COUNT(DISTINCT ?workPackage) AS ?count) WHERE {
        ?Procedure a :Procedure;
                   :name ?ProcedureName.
           filter (?Procedure in (id:#{procedure_id}))
        ?Procedure :procedureHasWorkPackage ?workPackage.
          }
    "
  end
end
