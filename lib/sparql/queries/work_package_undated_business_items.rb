module Sparql::Queries::WorkPackageUndatedBusinessItems

  # A SPARQL query to get a work package and its undated business items.
  def work_package_undated_business_items_query( work_package_id )
    "
      PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX id: <https://id.parliament.uk/>
      SELECT ?businessItem ?businessItemDate ?businessItemLink ?businessItemProcedureStep ?businessItemProcedureStepName ?legislature ?legislatureName ?CommonsId ?LordsId where {
       ?Paper a :WorkPackagedThing .  
           ?Paper :name ?Papername ;
           :workPackagedThingHasWorkPackage ?workPackage.
          filter (?workPackage IN (id:#{work_package_id}))
           ?workPackage :workPackageHasBusinessItem ?businessItem;
                        :workPackageHasProcedure ?procedure.
         minus {?businessItem :businessItemDate ?businessItemDate}
        optional {?businessItem :businessItemHasBusinessItemWebLink ?businessItemLink}
       ?businessItem :businessItemHasProcedureStep ?businessItemProcedureStep. 
       ?businessItemProcedureStep :name ?businessItemProcedureStepName.
         Optional {?businessItemProcedureStep :procedureStepInLegislature ?legislature.
          ?legislature :name ?legislatureName.}
        Optional {?businessItemProcedureStep :procedureStepHasHouse ?CommonsId.
              filter (?CommonsId IN (id:1AFu55Hs))}
        Optional {?businessItemProcedureStep :procedureStepHasHouse ?LordsId.
          filter (?LordsId IN (id:WkUWUBMx))}}
 
      
    "
  end
end
