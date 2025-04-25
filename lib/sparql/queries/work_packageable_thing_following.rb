module Sparql::Queries::WorkPackageableThingFollowing

  # A SPARQL query to get a list of all following work packageable things for a work packageable thing.
  def work_packageable_thing_following_query( work_packageable_thing_id )
    "
      PREFIX id: <https://id.parliament.uk/>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      select ?WorkPackagedThing ?workPackagedThingName ?FollowedWorkPackagedThing ?FollowedWorkPackagedThingName where {
        ?WorkPackagedThing a :WorkPackagedThing;
                           :name ?workPackagedThingName.
        ?WorkPackagedThing :workPackagedThingHasWorkPackage ?workPackage.
          ?WorkPackagedThing :followedBy ?FollowedWorkPackagedThing.   
        ?FollowedWorkPackagedThing :name ?FollowedWorkPackagedThingName.
        filter (?WorkPackagedThing in (id:#{work_packageable_thing_id}))
              } 
      
    "
  end
end



