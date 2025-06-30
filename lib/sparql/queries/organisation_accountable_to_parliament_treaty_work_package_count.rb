module Sparql::Queries::OrganisationAccountableToParliamentTreatyWorkPackageCount

  # A SPARQL query to get a count of all work packages for treaties lead by an organisation accountable to Parliament.
  def organisation_accountable_to_parliament_treaty_work_package_count_query( organisation_accountable_to_parliament_id )
    "
      PREFIX : <https://id.parliament.uk/schema/>
          PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
          PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
          PREFIX id: <https://id.parliament.uk/>
          SELECT distinct (COUNT(DISTINCT ?WorkPackage) AS ?count)  WHERE {
           { ?Organisations a :GovernmentOrganisation.}
           UNION {
          ?Organisations a :ArmsLengthBody.
                          }
            ?Organisations :name ?Name;
                           :leadGovernmentOrganisationHasTreaty ?treaty.
            ?treaty :name ?TreatyName;
                    :workPackagedThingHasWorkPackage ?WorkPackage.
              OPTIONAL
            {
              ?treaty :treatyHasCountrySeriesMembership ?treatyHasCountrySeriesMembership .
              ?treatyHasCountrySeriesMembership :seriesItemCitation ?countrySeriesItemCitation .
            }
            OPTIONAL
            {
              ?treaty :treatyHasEuropeanUnionSeriesMembership ?treatyHasEuropeanUnionSeriesMembership .
              ?treatyHasEuropeanUnionSeriesMembership :seriesItemCitation ?europeanSeriesItemCitation .
            }
            OPTIONAL
            {
              ?treaty :treatyHasMiscellaneousSeriesMembership ?treatyHasMiscellaneousSeriesMembership .
              ?treatyHasMiscellaneousSeriesMembership :seriesItemCitation ?miscSeriesItemCitation .
            }
 
             filter (?Organisations in (id:#{organisation_accountable_to_parliament_id}))
         optional {?WorkPackage :workPackageHasBusinessItem ?businessItem .
                      ?businessItem :businessItemHasProcedureStep ?step;
                             :businessItemDate ?businessItemDate.
                      filter (?step in (id:isWn7s3K, id:cspzmb6w, id:ITNO9JWr, id:otscOTzB))}
                      ?WorkPackage :workPackageHasProcedure ?procedure.
                    ?procedure :name ?procedureName.
                         optional { ?WorkPackage :workPackageHasCalculationStyle ?calculationStyle. 
               ?calculationStyle :name ?calculationStyleName. }
          } 
    
    "
  end
end
