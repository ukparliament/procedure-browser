module Sparql::Queries::BusinessItemSteps

  # A SPARQL query to get steps for a business item.
  def business_item_steps_query( business_item_id )
    "
    PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
          PREFIX : <https://id.parliament.uk/schema/>
          PREFIX id: <https://id.parliament.uk/>
          SELECT ?businessItem ?workPackage ?workPackagedThing ?workPackagedThingLabel ?procedure ?procedureLabel ?calculationStyle ?calculationStyleLabel ?madeAvailableDate ?businessItemstep ?businessItemStepName ?stepDepth ?Date ?url ?legislature ?legislatureName ?CommonsId ?LordsId WHERE {
          ?businessItem a :BusinessItem;
                        :businessItemHasWorkPackage ?workPackage;
                 :businessItemHasProcedureStep ?businessItemstep.
            ?workPackage :workPackageHasProcedure ?procedure;
                                        :workPackageHasWorkPackagedThing ?workPackagedThing.
            ?procedure :name ?procedureLabel.
      ?businessItemstep :procedureStepHasStepDisplayDepthInProcedure ?businessItemStepDepth.
      ?businessItemStepDepth :stepDisplayDepthInProcedureHasProcedure ?procedure.
      ?businessItemStepDepth :stepDisplayDepthInProcedureHasDepth ?stepDepth. 
            ?workPackagedThing :name ?workPackagedThingLabel. 
            optional {?workPackage :workPackageHasCalculationStyle ?calculationStyle.
              ?calculationStyle :name ?calculationStyleLabel. }
            optional {?businessItem :date ?Date.}
            optional {?businessItem :businessItemHasBusinessItemWebLink ?url}
            ?businessItemstep :name ?businessItemStepName.
             Optional {?businessItemstep :procedureStepInLegislature ?legislature.
              ?legislature :name ?legislatureName.}
            Optional {?businessItemstep:procedureStepHasHouse ?CommonsId.
                  filter (?CommonsId IN (id:1AFu55Hs))}
            Optional {?businessItemstep :procedureStepHasHouse ?LordsId.
              filter (?LordsId IN (id:WkUWUBMx))} 
            filter (?businessItem in (id:#{business_item_id}))
            optional {  ?workPackage :workPackageHasBusinessItem ?bi.
            ?bi :businessItemHasProcedureStep ?procedureStep.
            ?bi :date ?madeAvailableDate.
              filter (?procedureStep in (id:cspzmb6w, id:isWn7s3K, id:ITNO9JWr, id:otscOTzB))}
          } order by ?stepDepth
    "
  end
end
