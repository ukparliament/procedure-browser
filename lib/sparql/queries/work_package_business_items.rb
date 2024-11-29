module Sparql::Queries::WorkPackageBusinessItems

  # A SPARQL query to get a work package and its business items.
  def work_package_business_items_query( work_package_id )
    "
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX id: <https://id.parliament.uk/>
      SELECT * where {
  
       ?Paper a :WorkPackagedThing .  
           ?Paper :name ?Papername ;
           :workPackagedThingHasWorkPackage ?workPackage.
        filter (?workPackage IN (id:#{work_package_id}))
           ?workPackage :workPackageHasBusinessItem ?businessItem. 
           ?workPackage :workPackageHasProcedure ?procedure.
         optional {?businessItem :businessItemDate ?businessItemDate}
        optional {?businessItem :businessItemHasBusinessItemWebLink ?businessItemLink}
       ?businessItem :businessItemHasProcedureStep ?businessItemProcedureStep. 
       ?businessItemProcedureStep :name ?businessItemProcedureStepName.
       ?businessItemProcedureStep :procedureStepHasStepDisplayDepthInProcedure ?stepDepth.
        ?procedure :procedureHasStepDisplayDepthInProcedure ?stepDepth.
       ?stepDepth :stepDisplayDepthInProcedureHasDepth ?depthValue.
        Optional {?businessItemProcedureStep :procedureStepInLegislature ?legislature.
          ?legislature :name ?legislatureName.}
        Optional {?businessItemProcedureStep :procedureStepHasHouse ?CommonsId.
              filter (?CommonsId IN (id:1AFu55Hs))}
        Optional {?businessItemProcedureStep :procedureStepHasHouse ?LordsId.
          filter (?LordsId IN (id:WkUWUBMx))} }  order by ?businessItemDate ?depthValue ?businessItem
    "
  end
end
