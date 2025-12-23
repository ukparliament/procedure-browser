module Sparql::Queries::EnablingLegislationByUri

  # A SPARQL query to get an item of enabling legislation by its legislation.gov.uk URI.
  def enabling_legislation_by_uri_query( enabling_legislation_uri )
    "
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX id: <https://id.parliament.uk/>
      SELECT * WHERE {
          ?Act a :ActOfParliament.
          ?Act :actOfParliamentName ?Name.
          OPTIONAL {?Act :actOfParliamentNumber ?Number}
          OPTIONAL {?Act :actOfParliamentYear ?Year}
          OPTIONAL{  ?Act :actOfParliamentRoyalAssentDate ?Date}
          OPTIONAL {?Act :actOfParliamentUrl ?URL}
          FILTER (?URL='#{enabling_legislation_uri}'^^xsd:string)
      }  
    "
  end
end