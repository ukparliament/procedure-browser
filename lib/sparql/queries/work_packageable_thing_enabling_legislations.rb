module Sparql::Queries::WorkPackageableThingEnablingLegislations

  # A SPARQL query to get a list of all enabling legislation for a work packageable thing.
  def work_packageable_thing_enabling_legislations_query( work_packageable_thing_id )
    "
      PREFIX id: <https://id.parliament.uk/>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      select ?WorkPackagedThing ?workPackagedThingName ?EnablingThing ?ActName ?RoyalAssentDate ?Year ?Number where {
        ?WorkPackagedThing a :WorkPackagedThing;
                           :name ?workPackagedThingName.
        optional {?WorkPackagedThing :enabledBy ?EnablingThing.  
          Optional { ?EnablingThing :actOfParliamentName ?ActName.}
         OPTIONAL {?EnablingThing :actOfParliamentNumber ?Number}
        OPTIONAL {?EnablingThing :actOfParliamentYear ?Year}
         OPTIONAL{  ?EnablingThing :actOfParliamentRoyalAssentDate ?RoyalAssentDate}
          OPTIONAL {?EnablingThing :actOfParliamentUrl ?URL}}
        filter (?WorkPackagedThing in (id:#{work_packageable_thing_id}))
      }Order by desc (?RoyalAssentDate)
      
    "
  end
end



