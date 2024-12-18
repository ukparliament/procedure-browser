module Sparql::Queries::ProcedureRoutes

  # A SPARQL query to get routes for a procedure.
  def procedure_routes_query( procedure_id )
    "
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX id: <https://id.parliament.uk/>
      SELECT * WHERE {
        ?Procedure a :Procedure;
                   :name ?ProcedureName.
         filter (?Procedure in (id:#{procedure_id}))
        ?Procedure :procedureHasProcedureRoute ?Route. 
        Optional {  ?Route :startDate ?StartDate. }
        Optional {?Route :endDate ?EndDate.}
        ?Route :procedureRouteIsFromProcedureStep ?FromStep. 
        ?FromStep :name ?FromStepName;
                  :procedureStepHasProcedureStepType ?FromStepType.
        ?FromStepType :name ?FromStepTypeName. 
          Optional {?FromStep :procedureStepInLegislature ?FromSteplegislature.
          ?FromSteplegislature :name ?FromSteplegislatureName.}
          Optional {?FromStep:procedureStepHasHouse ?FromStepCommonsId
          filter (?FromStepCommonsId IN (id:1AFu55Hs))}
          Optional {?FromStep :procedureStepHasHouse ?FromStepLordsId.
            filter (?FromStepLordsId IN (id:WkUWUBMx))}
          ?Route :procedureRouteIsToProcedureStep ?ToStep. 
        ?ToStep :name ?ToStepName;
                  :procedureStepHasProcedureStepType ?ToStepType.
        ?ToStepType :name ?ToStepTypeName. 
        Optional {?ToStep :procedureStepInLegislature ?ToSteplegislature.
          ?ToSteplegislature :name ?ToSteplegislatureName.}
          Optional {?ToStep:procedureStepHasHouse ?ToStepCommonsId
          filter (?ToStepCommonsId IN (id:1AFu55Hs))}
          Optional {?ToStep :procedureStepHasHouse ?ToStepLordsId.
            filter (?ToStepLordsId IN (id:WkUWUBMx))}
  
        } Order by ?FromStepName ?FromStepTypeName ?ToStepName ?ToStepTypeName
    "
  end
end