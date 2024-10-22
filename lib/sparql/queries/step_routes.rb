module Sparql::Queries::StepRoutes

  # A SPARQL query to get routes for a step.
  def step_routes_query( step_id )
    "
      PREFIX id: <https://id.parliament.uk/>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      SELECT ?Route ?startDate ?endDate ?procedure ?procedureLabel ?FromStep ?FromStepName ?FromStepType ?FromStepTypeName ?FromStepCommonsId ?FromStepLordsId ?FromSteplegislature ?FromSteplegislatureName ?ToStep ?ToStepName ?ToStepType ?ToStepTypeName ?ToStepCommonsId ?ToStepLordsId ?ToSteplegislature ?ToSteplegislatureName WHERE {

        ?Step a :ProcedureStep;
                  :name ?stepName.
              ?Step :procedureStepIsFromProcedureRoute | :procedureStepIsToProcedureRoute ?Route.
         optional {?Route:procedureRouteStartDate ?startDate}
        optional {?Route :procedureRouteEndDate ?endDate}
        ?Route :procedureRouteHasProcedure ?procedure.
        ?procedure :name ?procedureLabel.
        ?Route :procedureRouteIsFromProcedureStep ?FromStep.
        ?Route :procedureRouteIsToProcedureStep ?ToStep.
        ?FromStep :name ?FromStepName;
                  :procedureStepHasProcedureStepType ?FromStepType.
          ?FromStepType :name ?FromStepTypeName. 
      ?ToStep :name ?ToStepName;
              :procedureStepHasProcedureStepType ?ToStepType.
          ?ToStepType :name ?ToStepTypeName.
          optional {?FromStep :procedureStepHasHouse ?FromStepCommonsId.
                    filter (?FromStepCommonsId IN (id:1AFu55Hs))}
              optional {?FromStep :procedureStepHasHouse ?FromStepLordsId.
          filter (?FromStepLordsId IN (id:WkUWUBMx))}
          optional {?FromStep :procedureStepInLegislature ?FromSteplegislature.
                ?FromSteplegislature :name ?FromSteplegislatureName.}
        optional {?ToStep :procedureStepHasHouse ?ToStepCommonsId.
                    filter (?ToStepCommonsId IN (id:1AFu55Hs))}
              optional {?ToStep :procedureStepHasHouse ?ToStepLordsId.
          filter (?ToStepLordsId IN (id:WkUWUBMx))}
          optional {?ToStep :procedureStepInLegislature ?ToSteplegislature.
                ?ToSteplegislature :name ?ToSteplegislatureName.}
          filter (?Step IN (id:#{step_id}))
      }
    "
  end
end