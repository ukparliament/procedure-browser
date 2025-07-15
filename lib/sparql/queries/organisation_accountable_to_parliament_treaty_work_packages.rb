module Sparql::Queries::OrganisationAccountableToParliamentTreatyWorkPackages

  # A SPARQL query to get a list of all work packages for treaties lead by an organisation accountable to Parliament.
  def organisation_accountable_to_parliament_treaty_work_packages_query( organisation_accountable_to_parliament_id, limit, offset )
    "
      PREFIX : <https://id.parliament.uk/schema/>
                PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
                PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
                PREFIX id: <https://id.parliament.uk/>
                SELECT distinct ?workPackage ?procedure ?procedureName ?treaty ?TreatyName ?treatyHasCountrySeriesMembership ?countrySeriesItemCitation ?treatyHasEuropeanUnionSeriesMembership ?europeanSeriesItemCitation ?treatyHasMiscellaneousSeriesMembership ?miscSeriesItemCitation ?combinedDate ?calculationStyle ?calculationStyleName  WHERE {
                 { ?Organisations a :GovernmentOrganisation.}
                 UNION {
                ?Organisations a :ArmsLengthBody.
                                }
                  ?Organisations :name ?Name;
                                 :leadGovernmentOrganisationHasTreaty ?treaty.
                  ?treaty :name ?TreatyName;
                          :workPackagedThingHasWorkPackage ?workPackage.
            ?workPackage :workPackageHasProcedure ?procedure.
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
      } Order by desc(?combinedDate) ?TreatyName                   
            limit #{limit} offset #{offset}
         
    "
  end
end
