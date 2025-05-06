module Sparql::Queries::OrganisationAccountableToParliamentTreatyCount

  # A SPARQL query to get a count of all treaties lead by an organisation accountable to Parliament.
  def organisation_accountable_to_parliament_treaty_count_query( organisation_accountable_to_parliament_id )
    "
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX id: <https://id.parliament.uk/>
      SELECT distinct (count(distinct ?treaty) as ?count) WHERE {
       { ?Organisations a :GovernmentOrganisation.}
       UNION {
      ?Organisations a :ArmsLengthBody.
                      }
        ?Organisations :name ?Name;
                       :leadGovernmentOrganisationHasTreaty ?treaty.
        ?treaty :name ?TreatyName;
                :workPackagedThingHasWorkPackage ?WorkPackage.
        ?WorkPackage :workPackageHasBusinessItem ?BusinessItem.
        ?BusinessItem :businessItemHasProcedureStep ?procedureStep;
                      :businessItemDate ?businessItemDate.
        filter (?procedureStep in (id:AmYrFxwO, id:cspzmb6w))
        optional {?treaty :treatyHasSeriesMembership ?series.
          ?series :seriesItemCitation ?seriesCitation}. 
  
        filter (?Organisations in (id:#{organisation_accountable_to_parliament_id}))
      } 
    "
  end
end
