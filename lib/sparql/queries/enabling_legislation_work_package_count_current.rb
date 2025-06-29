module Sparql::Queries::EnablingLegislationWorkPackageCountCurrent

  # A SPARQL query to get a count of current work packages for an item of enabling legislation.
  def enabling_legislation_work_package_count_current_query( enabling_thing_id )
    "
      PREFIX : <https://id.parliament.uk/schema/>
        PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
        PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
        PREFIX id: <https://id.parliament.uk/>
        SELECT (COUNT(DISTINCT ?workPackage) AS ?count) WHERE {
         ?Act a :ActOfParliament.
          ?Act :actOfParliamentName ?Name.
           OPTIONAL {?Act :actOfParliamentNumber ?Number}
          OPTIONAL {?Act :actOfParliamentYear ?Year}
           OPTIONAL{  ?Act :actOfParliamentRoyalAssentDate ?Date}
          OPTIONAL {?Act :actOfParliamentUrl ?URL}
          filter (?Act in (id:#{enabling_thing_id}))
          ?Act :enabling ?workPackagedThing. 
          ?workPackagedThing :name ?workPackagedThingName. 
   ?workPackagedThing :workPackagedThingHasWorkPackage ?workPackage.
           optional {?workPackage :workPackageHasBusinessItem ?businessItem .
             ?businessItem :businessItemHasProcedureStep ?step;
                    :businessItemDate ?businessItemDate.
             filter (?step in (id:isWn7s3K, id:cspzmb6w, id:ITNO9JWr, id:otscOTzB))}
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
