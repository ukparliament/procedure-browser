module Sparql::Queries::WorkPackageCountCurrent

  # A SPARQL query to get a count of current work packages.
  def work_package_current_count_query
    "
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX id: <https://id.parliament.uk/>
      select distinct  (COUNT(DISTINCT ?workPackage) AS ?count) where {

       ?Paper a :WorkPackagedThing .  
           ?Paper :name ?Papername ;
           :workPackagedThingHasWorkPackage ?workPackage.
        optional {?Paper :laidThingHasLaying ?laying.
          ?laying :layingDate ?laidDate}
          ?workPackage :workPackageHasProcedure ?procedure.
        ?procedure :name ?procedureName.
       optional { ?workPackage :workPackageHasCalculationStyle ?calculationStyle. 
          ?calculationStyle :name ?calculationStyleName. }
  MINUS {  ?workPackage   :workPackageHasBusinessItem ?bi2.
  ?bi2 :businessItemHasProcedureStep ?stepId2.
     ?stepId2 :procedureStepHasProcedureStepCollectionMembership/:procedureStepCollectionMembershipHasProcedureStepCollection id:TRohjSuI}
         }    
    "
  end
end
