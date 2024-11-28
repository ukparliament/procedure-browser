module Sparql::Queries::BusinessItemSteps

  # A SPARQL query to get steps for a business item.
  def business_item_steps_query( business_item_id )
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
          filter (?event in (id:#{business_item_id}))
      }
    "
  end
end
