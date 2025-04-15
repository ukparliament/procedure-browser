module Sparql::Queries::WorkPackageableThing

  # A SPARQL query to get a work packageable thing.
  def work_packageable_thing_query( work_packageable_thing_id )
    "
      PREFIX id: <https://id.parliament.uk/>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      select * where {
        ?WorkPackagedThing a :WorkPackagedThing;
                           :name ?workPackagedThingName.
        filter (?WorkPackagedThing in (id:#{work_packageable_thing_id}))
      } 
    "
  end
end