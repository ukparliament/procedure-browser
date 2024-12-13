module Sparql::Queries::ProcedureStepBusinessItems

  # A SPARQL query to get business items for a step in a procedure.
  def procedure_step_business_items_query( procedure_id, step_id )
    "
    PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
    PREFIX : <https://id.parliament.uk/schema/>
    PREFIX id: <https://id.parliament.uk/>
    SELECT distinct ?Procedure ?ProcedureName ?step ?stepName ?legislature ?legislatureName ?CommonsId ?LordsId ?stepType ?stepTypeLabel ?businessItem ?businessItemDate ?businessItemLink  WHERE {
      ?Procedure a :Procedure;
                 :name ?ProcedureName.
         filter (?Procedure in (id:#{procedure_id}))
      ?Procedure :procedureHasWorkPackage ?workPackage.
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
      filter (?step IN (id:#{step_id}))
     ?step :procedureStepHasBusinessItem ?businessItem.
      optional{ ?businessItem :businessItemDate ?businessItemDate.}
            optional {?businessItem :businessItemHasBusinessItemWebLink ?businessItemLink }
      ?businessItem :businessItemHasWorkPackage ?workPackage.
       } order by ?stepName
    "
  end
end