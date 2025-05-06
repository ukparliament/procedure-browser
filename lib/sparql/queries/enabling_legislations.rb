module Sparql::Queries::EnablingLegislations

  # A SPARQL query to get all enabling legislation taking parameters of limit and offset.
  def enabling_legislations_query( limit, offset )
    "
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX id: <https://id.parliament.uk/>
      SELECT distinct ?EnablingThing ?Name ?Number ?Year ?Date ?URL WHERE {
        ?EnablingThing a :EnablingThing;  
             :enabling ?EnabledThing.
        Optional { ?EnablingThing  :actOfParliamentName ?Name;}
        OPTIONAL {?EnablingThing :actOfParliamentNumber ?Number}
        OPTIONAL {?EnablingThing:actOfParliamentYear ?Year}
        OPTIONAL{  ?EnablingThing :actOfParliamentRoyalAssentDate ?Date}
        OPTIONAL {?EnablingThing :actOfParliamentUrl ?URL}
        ?EnabledThing :name ?EnabledThingName.
          
       
      }  order by desc(?Date) ?Name

      offset #{offset} limit #{limit}
    "
  end
end
