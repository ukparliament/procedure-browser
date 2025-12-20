module Sparql::Queries::CalculationStyleWorkPackagesAll

  # A SPARQL query to get work packages for a calculation style.
  def calculation_style_work_packages_all_query( calculation_style_id )
    "
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
           PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
           PREFIX : <https://id.parliament.uk/schema/>
           PREFIX id: <https://id.parliament.uk/>
           SELECT ?CalculationStyle ?CalculationStyleName ?workPackage ?combinedDate ?workPackagedThing ?workPackagedThingName ?procedure ?procedureName WHERE {
             ?CalculationStyle a :CalculationStyle;
                        :name ?CalculationStyleName;
                        :calculationStyleHasWorkPackage ?workPackage.
       filter (?CalculationStyle in (id:#{calculation_style_id}))
                     optional {   ?workPackage :workPackageHasBusinessItem ?businessItem .
                ?businessItem :businessItemHasProcedureStep ?step;
                       :businessItemDate ?businessItemDate.
         filter (?step in (id:isWn7s3K, id:cspzmb6w, id:ITNO9JWr, id:otscOTzB))}
         optional {    ?workPackage :workPackageHasBusinessItem ?businessItem2 .
                ?businessItem2 :businessItemHasProcedureStep ?step2;
                               :businessItemDate ?businessItemDate2.
         filter (?step2 in (id:AmYrFxwO))}
       			?workPackage :workPackageHasWorkPackagedThing ?workPackagedThing.
       			?workPackagedThing :name ?workPackagedThingName. 
                 ?workPackage :workPackageHasProcedure ?procedure.
               ?procedure :name ?procedureName.
        BIND(COALESCE(?businessItemDate, ?businessItemDate2) AS ?combinedDate)
      } Order by desc(?combinedDate) ?workPackagedThingName
    "
  end
end