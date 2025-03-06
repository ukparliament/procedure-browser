module Sparql::Queries::EnablingLegislations

  # A SPARQL query to get all enabling legislation taking parameters of limit and offset.
  def enabling_legislations_query( limit, offset )
    "
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      SELECT * WHERE {
       ?Act a :ActOfParliament.
        ?Act :actOfParliamentName ?Name.
         OPTIONAL {?Act :actOfParliamentNumber ?Number}
        OPTIONAL {?Act :actOfParliamentYear ?Year}
         OPTIONAL{  ?Act :actOfParliamentRoyalAssentDate ?Date}
        OPTIONAL {?Act :actOfParliamentUrl ?URL}
  
      } Order by desc(?Date)
      LIMIT #{limit} OFFSET #{offset}
    "
  end
end
