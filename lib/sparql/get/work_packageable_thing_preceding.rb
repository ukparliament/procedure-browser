module Sparql::Get::WorkPackageableThingPreceding
  
  # A method to get an array of all preceding work packageable things for a work packageable thing.
  def get_work_packageable_thing_preceding( work_packageable_thing_id )
  
    # We get the work packageable thing preceding query.
    request_body = work_packageable_thing_preceding_query( work_packageable_thing_id )
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
  
    # We construct an array to hold the work packageable things.
    work_packageable_things = []
  
    # For each row in the CSV ...
    csv.each do |row|
  
      # ... we create a new work packageable thing object ...
      work_packageable_thing = WorkPackageableThing.new
      work_packageable_thing.identifier = row['precededWorkPackagedThing']
      work_packageable_thing.label = row['precededWorkPackagedThingName']
      
      # ... and add it to the array of work packageable things.
      work_packageable_things << work_packageable_thing
    end
  
    # We return the array of work packageable things.
    work_packageable_things
  end
end