module Sparql::Queries::EnablingLegislationCount

  # A SPARQL query to get a count of all enabling legislation.
  def enabling_legislation_count_query
    "
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX id: <https://id.parliament.uk/>
      SELECT distinct (COUNT(DISTINCT ?EnablingThing) AS ?count) WHERE {
        ?EnablingThing a :EnablingThing;  
             :enabling ?EnabledThing.
        Optional { ?EnablingThing  :actOfParliamentName ?Name;}
        OPTIONAL {?EnablingThing :actOfParliamentNumber ?Number}
        OPTIONAL {?EnablingThing:actOfParliamentYear ?Year}
        OPTIONAL{  ?EnablingThing :actOfParliamentRoyalAssentDate ?Date}
        OPTIONAL {?EnablingThing :actOfParliamentUrl ?URL}
        ?EnabledThing :name ?EnabledThingName;
        :workPackagedThingHasWorkPackage ?workPackage.
                optional {?workPackage :workPackageHasBusinessItem ?businessItem .
                  ?businessItem :businessItemHasProcedureStep ?step;
                         :businessItemDate ?businessItemDate.
                  filter (?step in (id:isWn7s3K, id:cspzmb6w, id:ITNO9JWr, id:otscOTzB))}
          
      }
    "
  end
end
