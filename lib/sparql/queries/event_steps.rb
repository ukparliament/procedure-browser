module Sparql::Queries::EventSteps

  # A SPARQL query to get steps for an event.
  def event_steps_query( event_id )
    "
        PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
        PREFIX : <https://id.parliament.uk/schema/>
        PREFIX id: <https://id.parliament.uk/>
        SELECT ?event ?step ?stepName ?eventDate ?url ?legislature ?legislatureName ?CommonsId ?LordsId WHERE {
        ?event a :BusinessItem;
               :businessItemHasProcedureStep ?step.
          optional {?event :date ?eventDate.}
          optional {?event :businessItemHasBusinessItemWebLink ?url}
          ?step :name ?stepName.
           Optional {?step :procedureStepInLegislature ?legislature.
            ?legislature :name ?legislatureName.}
          Optional {?step:procedureStepHasHouse ?CommonsId.
                filter (?CommonsId IN (id:1AFu55Hs))}
          Optional {?step :procedureStepHasHouse ?LordsId.
            filter (?LordsId IN (id:WkUWUBMx))} 
          filter (?event in (id:#{event_id}))
      }
    "
  end
end
