module Sparql::Queries::OrganisationAccountableToParliamentTreatyWorkPackages

  # A SPARQL query to get a list of all work packages for treaties lead by an organisation accountable to Parliament.
  def organisation_accountable_to_parliament_treaty_work_packages_query( organisation_accountable_to_parliament_id, limit, offset )
    "
      PREFIX : <https://id.parliament.uk/schema/>
          PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
          PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
          PREFIX id: <https://id.parliament.uk/>
          SELECT distinct ?WorkPackage ?procedure ?procedureName ?treaty ?TreatyName ?treatyHasCountrySeriesMembership ?countrySeriesItemCitation ?treatyHasEuropeanUnionSeriesMembership ?europeanSeriesItemCitation ?treatyHasMiscellaneousSeriesMembership ?miscSeriesItemCitation ?businessItemDate ?calculationStyle ?calculationStyleName  WHERE {
           { ?Organisations a :GovernmentOrganisation.}
           UNION {
          ?Organisations a :ArmsLengthBody.
                          }
            ?Organisations :name ?Name;
                           :leadGovernmentOrganisationHasTreaty ?treaty.
            ?treaty :name ?TreatyName;
                    :workPackagedThingHasWorkPackage ?WorkPackage.
      ?WorkPackage :workPackageHasProcedure ?procedure.
      ?procedure :name ?procedureName.
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
          } Order by desc(?businessItemDate) ?TreatyName                   
      
          offset #{offset} limit #{limit}
    "
  end
end
