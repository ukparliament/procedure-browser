module Sparql::Queries::WorkPackageEvents

  # A SPARQL query to get a work package and its events.
  def work_package_events_query( work_package_id )
    "
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX id: <https://id.parliament.uk/>
      SELECT * where {
  
       ?Paper a :WorkPackagedThing .  
           ?Paper :name ?Papername ;
           :workPackagedThingHasWorkPackage ?workPackage.
        filter (?workPackage IN (id:#{work_package_id}))
           ?workPackage :workPackageHasBusinessItem ?event. 
           ?workPackage :workPackageHasProcedure ?procedure.
         optional {?event :businessItemDate ?eventDate}
        optional {?event :businessItemHasBusinessItemWebLink ?eventLink}
       ?event :businessItemHasProcedureStep ?eventProcedureStep. 
       ?eventProcedureStep :name ?eventProcedureStepName.
       ?eventProcedureStep :procedureStepHasStepDisplayDepthInProcedure ?stepDepth.
        ?procedure :procedureHasStepDisplayDepthInProcedure ?stepDepth.
       ?stepDepth :stepDisplayDepthInProcedureHasDepth ?depthValue.
        Optional {?eventProcedureStep :procedureStepInLegislature ?legislature.
          ?legislature :name ?legislatureName.}
        Optional {?eventProcedureStep:procedureStepHasHouse ?CommonsId.
              filter (?CommonsId IN (id:1AFu55Hs))}
        Optional {?eventProcedureStep :procedureStepHasHouse ?LordsId.
          filter (?LordsId IN (id:WkUWUBMx))} }  order by ?eventDate ?depthValue ?event
    "
  end
end
