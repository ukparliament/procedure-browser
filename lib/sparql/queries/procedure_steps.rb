module Sparql::Queries::ProcedureSteps

  # A SPARQL query to get steps for a procedure.
  def procedure_steps_query( procedure_id )
    "
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX id: <https://id.parliament.uk/>
      SELECT distinct ?Procedure ?ProcedureName ?step ?stepName ?legislature ?legislatureName ?CommonsId ?LordsId ?stepType ?stepTypeLabel WHERE {
        ?Procedure a :Procedure;
                   :name ?ProcedureName.
           filter (?Procedure in (id:#{procedure_id}))
        optional {  ?Procedure :procedureHasProcedureRoute ?Route.
          ?Route :procedureRouteIsFromProcedureStep|:procedureRouteIsToProcedureStep ?step.
          ?step :name ?stepName.
        ?step :procedureStepHasProcedureStepType ?stepType.
               ?stepType :name ?stepTypeLabel.}
          Optional {?step :procedureStepInLegislature ?legislature.
          ?legislature :name ?legislatureName.}
          Optional {?step :procedureStepHasHouse ?CommonsId
          filter (?CommonsId IN (id:1AFu55Hs))}
          Optional {?step :procedureStepHasHouse ?LordsId.
            filter (?LordsId IN (id:WkUWUBMx))}
        } order by ?stepName 
      
    "
  end
end