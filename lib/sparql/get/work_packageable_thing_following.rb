module Sparql::Get::WorkPackageableThingFollowing
  
  # A method to get an array of all following work packageable things for a work packageable thing.
  def get_work_packageable_thing_following( work_packageable_thing_id )
  
    # We get the work packageable thing following query.
    request_body = work_packageable_thing_following_query( work_packageable_thing_id )
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
  
    # We construct an array to hold the work packageable things.
    work_packageable_things = []
  
    # For each row in the CSV ...
    csv.each do |row|
  
      # ... we create a new work packageable thing object ...
      work_packageable_thing = WorkPackageableThing.new
      work_packageable_thing.identifier = row['FollowedWorkPackagedThing']
      work_packageable_thing.label = row['FollowedWorkPackagedThingName']
      
      # ... and add it to the array of work packageable things.
      work_packageable_things << work_packageable_thing
    end
  
    # We return the array of work packageable things.
    work_packageable_things
  end
end