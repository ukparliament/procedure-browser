module Sparql::Get::WorkPackageableThingByUri

  # A method to get a work packageable thing by its legislation.gov.uk URI.
  def get_work_packageable_thing_by_uri( work_packageable_thing_uri )
  
    # We get the work packageable thing by uri query.
    request_body = work_packageable_thing_by_uri_query( work_packageable_thing_uri )
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # If the legislation item doesn't exist, the csv will be an empty array.
    # If the array is an empty array ...
    if csv.empty?
      
      # ... we return nil.
      return nil
      
    # Otherwise, if the CSV is not an empty array ...
    else
    
      # ... we take the one and only row from the CSV ...
      csv.take( 1 ).each do |row|
    
        # ... and create a new work packageable thing object.
        work_packageable_thing = WorkPackageableThing.new
        work_packageable_thing.identifier = row['WorkPackagedThing']
        
        # We return the work packageable thing object.
        return work_packageable_thing
      end
    end
  end
end