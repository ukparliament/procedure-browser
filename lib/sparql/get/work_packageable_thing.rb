module Sparql::Get::WorkPackageableThing

  # A method to get a work packageable thing.
  def get_work_packageable_thing( work_packageable_thing_id )
  
    # We get the work_packageable_thing query.
    request_body = work_packageable_thing_query( work_packageable_thing_id )
  
    # We get the SPARQL response as a CSV.
    #csv = get_sparql_response_as_csv( request_body )
    
    # We take the one and only row from the CSV ...
    #csv.take( 1 ).each do |row|
    
      # ... and create a new work packageable thing object.
      #work_packageable_thing = WorkPackageableThing.new
      #work_packageable_thing.identifier = row['workPackageableThing']
      #work_packageable_thing.label = row['workPackageableThingLabel']
      
      # We return the work packageable thing object.
      #return work_packageable_thing
    #end
  end
end