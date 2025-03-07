module Sparql::Queries::EnablingLegislationWorkPackageableThings

  # A SPARQL query to get work packageable things enabled by an item of legislation.
  def enabling_legislation_work_packageable_things_query( enabling_thing_id, limit, offset )
    "
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX id: <https://id.parliament.uk/>
      SELECT ?workPackagedThing ?workPackagedThingName WHERE {
       ?Act a :ActOfParliament.
        ?Act :actOfParliamentName ?Name.
         OPTIONAL {?Act :actOfParliamentNumber ?Number}
        OPTIONAL {?Act :actOfParliamentYear ?Year}
         OPTIONAL{  ?Act :actOfParliamentRoyalAssentDate ?Date}
        OPTIONAL {?Act :actOfParliamentUrl ?URL}
        filter (?Act in (id:#{enabling_thing_id}))
        ?Act :enabling ?workPackagedThing. 
        ?workPackagedThing :name ?workPackagedThingName. 
      }                      
       LIMIT #{limit} OFFSET #{offset}
    "
  end
end