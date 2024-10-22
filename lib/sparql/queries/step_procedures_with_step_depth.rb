module Sparql::Queries::StepProceduresWithStepDepth

  # A SPARQL query to get procedures with step depth for a step.
  def step_procedures_with_step_depth_query( step_id )
    "
      PREFIX id: <https://id.parliament.uk/>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      SELECT ?Step ?stepName ?procedure ?procedureLabel ?procedureDescription ?stepDepth ?depthValue WHERE {

        ?Step a :ProcedureStep;
                  :name ?stepName;
                  :procedureStepHasStepDisplayDepthInProcedure ?stepDepth.
          filter (?Step IN (id:#{step_id}))
        ?stepDepth :stepDisplayDepthInProcedureHasDepth ?depthValue;
          :stepDisplayDepthInProcedureHasProcedure ?procedure.
        ?procedure :name ?procedureLabel.
        optional {?procedure :procedureDescription ?procedureDescription.}
        } order by ?stepName ?procedureLabel ?depthValue
    "
  end
end