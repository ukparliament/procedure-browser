module Sparql::Queries::StepProcedures

  # A SPARQL query to get procedures for a step.
  def step_procedures_query( step_id )
    "
      PREFIX id: <https://id.parliament.uk/>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      SELECT distinct ?Step ?stepName  ?procedure ?procedureLabel ?procedureDescription WHERE {

        ?Step a :ProcedureStep;
                  :name ?stepName;
                  :procedureStepIsToProcedureRoute ?procedureRoute.
                     filter (?Step IN (id:#{step_id}))
        ?procedureRoute :procedureRouteHasProcedure ?procedure.
        ?procedure :name ?procedureLabel.
        optional {?procedure :procedureDescription ?procedureDescription.}
         } order by ?stepName ?procedureLabel
    "
  end
end