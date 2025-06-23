module Sparql::Queries::ProcedureWorkPackageCountCurrent

  # A SPARQL query to get a count of current work packages in a procedure.
  def procedure_work_package_count_current_query( procedure_id )
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
        MINUS {  ?workPackage   :workPackageHasBusinessItem ?bi2.
       ?bi2 :businessItemHasProcedureStep ?stepId2.
          ?stepId2 :procedureStepHasProcedureStepCollectionMembership/:procedureStepCollectionMembershipHasProcedureStepCollection id:TRohjSuI}
               }
    "
  end
end
