module Sparql::Get::WorkPackageableThings

  # A method to get an array of all work packageable things on this page with this many results per page.
  def get_work_packageable_things( page_number, results_per_page )
  
    # We calculate the result offset.
    result_offset = ( ( page_number - 1) * results_per_page )

    # We get the all work packageable things query passing parameters for the number of results per page and the result offset.
    request_body = work_packageable_things_query( results_per_page, result_offset )
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
  
    # We construct an array to hold the work packageable things.
    work_packageable_things = []
  
    # For each row in the CSV ...
    csv.each do |row|
  
      # ... we create a new work packageable thing object ...
      work_packageable_thing = WorkPackageableThing.new
      work_packageable_thing.identifier = row['WorkPackagedThing']
      work_packageable_thing.label = row['workPackagedThingName']
      
      # ... and add it to the array of work packageable things.
      work_packageable_things << work_packageable_thing
    end
  
    # We return the array of work packageable things.
    work_packageable_things
  end
end