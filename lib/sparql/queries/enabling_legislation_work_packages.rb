module Sparql::Queries::EnablingLegislationWorkPackages

  # A SPARQL query to get work packages enabled by an item of legislation.
  def enabling_legislation_work_packages_query( enabling_thing_id, limit, offset )
    "
      PREFIX : <https://id.parliament.uk/schema/>
           PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
           PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
           PREFIX id: <https://id.parliament.uk/>
           SELECT ?workPackage ?workPackagedThing ?workPackagedThingName ?combinedDate ?procedure ?procedureName ?calculationStyle ?calculationStyleName  WHERE {
            ?Act a :ActOfParliament.
             ?Act :actOfParliamentName ?Name.
              OPTIONAL {?Act :actOfParliamentNumber ?Number}
             OPTIONAL {?Act :actOfParliamentYear ?Year}
              OPTIONAL{  ?Act :actOfParliamentRoyalAssentDate ?Date}
             OPTIONAL {?Act :actOfParliamentUrl ?URL}
             filter (?Act in (id:#{enabling_thing_id}))
             ?Act :enabling ?workPackagedThing. 
             ?workPackagedThing :name ?workPackagedThingName;
                                :workPackagedThingHasWorkPackage ?workPackage.
                     optional {   ?workPackage :workPackageHasBusinessItem ?businessItem .
                ?businessItem :businessItemHasProcedureStep ?step;
                       :businessItemDate ?businessItemDate.
         filter (?step in (id:isWn7s3K, id:cspzmb6w, id:ITNO9JWr, id:otscOTzB))}
         optional {    ?workPackage :workPackageHasBusinessItem ?businessItem2 .
                ?businessItem2 :businessItemHasProcedureStep ?step2;
                               :businessItemDate ?businessItemDate2.
         filter (?step2 in (id:AmYrFxwO))}
                       ?workPackage :workPackageHasProcedure ?procedure.
                     ?procedure :name ?procedureName.
                          optional { ?workPackage :workPackageHasCalculationStyle ?calculationStyle. 
                ?calculationStyle :name ?calculationStyleName. }
       BIND(COALESCE(?businessItemDate, ?businessItemDate2) AS ?combinedDate)
     } Order by desc(?combinedDate)
               
           limit #{limit} offset #{offset}
    "
  end
end