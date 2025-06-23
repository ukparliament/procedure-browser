module Sparql::Queries::CalculationStyleWorkPackageCountCurrent

  # A SPARQL query to get a count of current work packages with a given calculation style.
  def calculation_style_work_package_count_current_query( calculation_style_id )
    "
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX id: <https://id.parliament.uk/>
      SELECT (COUNT(DISTINCT ?workPackage) AS ?count) WHERE {
        ?CalculationStyle a :CalculationStyle;
                   :name ?CalculationStyleName;
                   :calculationStyleHasWorkPackage ?workPackage.
  filter (?CalculationStyle in (id:#{calculation_style_id}))
                optional {?workPackage :workPackageHasBusinessItem ?businessItem .
            ?businessItem :businessItemHasProcedureStep ?step;
                   :businessItemDate ?MadeAvailableDate.
            filter (?step in (id:isWn7s3K, id:cspzmb6w, id:ITNO9JWr, id:otscOTzB))}
  			?workPackage :workPackageHasWorkPackagedThing ?workPackagedThing.
  			?workPackagedThing :name ?workPackagedThingName. 
            ?workPackage :workPackageHasProcedure ?procedure.
          ?procedure :name ?procedureName.
      MINUS {  ?workPackage   :workPackageHasBusinessItem ?bi2.
  ?bi2 :businessItemHasProcedureStep ?stepId2.
     ?stepId2 :procedureStepHasProcedureStepCollectionMembership/:procedureStepCollectionMembershipHasProcedureStepCollection id:TRohjSuI}
        }
    "
  end
end