module Sparql::Queries::OrganisationAccountableToParliamentMakingAvailableCount

  # A SPARQL query to get a count of all making avilabless for an organisation accountable to Parliament.
  def organisation_accountable_to_parliament_making_available_count_query( organisation_accountable_to_parliament_id )
    "
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX id: <https://id.parliament.uk/>
      SELECT distinct (count(distinct ?LaidThing) as ?count) WHERE {
       { ?Organisations a :GovernmentOrganisation.}
       UNION {
      ?Organisations a :ArmsLengthBody.
                      }
        ?Organisations :name ?Name;
                       :layingBodyHasLaying ?Laying.
        ?Laying :layingHasLaidThing ?LaidThing;
                :businessItemHasProcedureStep ?Step;
                :layingDate ?LaidDate.
        filter (?Step in (id:cspzmb6w, id:isWn7s3K))
        ?LaidThing :name ?LaidThingName. 
        filter (?Organisations in (id:#{organisation_accountable_to_parliament_id}))
  
  
      }
    "
  end
end
