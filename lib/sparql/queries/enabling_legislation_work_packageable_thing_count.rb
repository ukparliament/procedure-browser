module Sparql::Queries::EnablingLegislationWorkPackageableThingCount

  # A SPARQL query to get a count of all work packageable things for an item of enabling legislation.
  def enabling_legislation_work_packageable_thing_count_query( enabling_thing_id )
    "
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX id: <https://id.parliament.uk/>
      SELECT (COUNT(DISTINCT ?workPackagedThing) AS ?count) WHERE {
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
       
    "
  end
end
