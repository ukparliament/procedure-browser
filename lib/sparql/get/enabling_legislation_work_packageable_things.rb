module Sparql::Get::EnablingLegislationWorkPackageableThings
  
  def get_enabling_legislation_work_packageable_things( enabling_thing_id, page_number, results_per_page )
  
    # We calculate the result offset.
    result_offset = ( ( page_number - 1) * results_per_page )
    
    # We get the enabling legislation work packageable things query.
    request_body = enabling_legislation_work_packageable_things_query( enabling_thing_id, results_per_page, result_offset )
    
    # We get the SPARQL response as a CSV.
    #csv = get_sparql_response_as_csv( request_body )
    
    # We construct an array to hold the work packageable things.
    #work_packageable_things = []
  
    # For each row in the CSV ...
    #csv.each do |row|
  
      # ... we create a new work packageable thing object ...
      #work_packageable_thing = WorkPackageableThing.new
      #work_packageable_thing.identifier = row['workPackageableThing']
      #work_packageable_thing.label = row['workPackageableThingName']
      
      # ... and add it to the array of work packageable things.
      #work_packageable_things << work_packageable_thing
    #end
  
    # We return the array of work packageable things.
    #work_packageable_things
  end
end