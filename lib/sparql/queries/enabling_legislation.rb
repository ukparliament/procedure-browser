module Sparql::Queries::EnablingLegislation

  # A SPARQL query to get an item of enabling legislation.
  def enabling_legislation_query( enabling_legislation_id )
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
        filter (?Act in (id:#{enabling_legislation_id}))
      }                      
           
    "
  end
end