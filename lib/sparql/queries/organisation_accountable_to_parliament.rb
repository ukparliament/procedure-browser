module Sparql::Queries::OrganisationAccountableToParliament

  # A SPARQL query to get an organisation accountable to parliament.
  def organisation_accountable_to_parliament_query( organisation_accountable_to_parliament_id )
    "
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX id: <https://id.parliament.uk/>
      SELECT * WHERE {
       { ?Organisations a :GovernmentOrganisation.}
       UNION {
      ?Organisations a :ArmsLengthBody.
                      }
        ?Organisations :name ?Name.
        optional {?Organisations :startDate ?startDate}
        optional {?Organisations :endDate ?endDate}
        filter (?Organisations in (id:#{organisation_accountable_to_parliament_id}))
      } 
    "
  end
end
