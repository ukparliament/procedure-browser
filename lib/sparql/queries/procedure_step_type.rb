module Sparql::Queries::ProcedureStepType

  # A SPARQL query to get a step type in a procedure.
  def procedure_step_type_query( procedure_id, step_type_id )
    "
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX id: <https://id.parliament.uk/>
      SELECT distinct ?Procedure ?ProcedureName ?stepType ?stepTypeLabel WHERE {
        ?Procedure a :Procedure;
                   :name ?ProcedureName.
           filter (?Procedure in (id:#{procedure_id}))
        optional {  ?Procedure :procedureHasProcedureRoute ?Route.
        ?Route :procedureRouteIsFromProcedureStep|:procedureRouteIsToProcedureStep ?step.
        ?step :procedureStepHasProcedureStepType ?stepType.
          ?stepType :name ?stepTypeLabel.}
        filter (?stepType in (id:#{step_type_id}))
       } 
    "
  end
end