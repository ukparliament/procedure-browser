# We require the module file for the step work packageable things query and the SPARQL response.
require 'sparql/queries/step_work_packageable_things'
require 'sparql/get/response'

module GET_STEP_WORK_PACKAGEABLE_THINGS

  Sparql::Get::StepWorkPackageableThings = true
  
  # We include the step work packageable things query and SPARQL response modules.
  include STEP_WORK_PACKAGEABLE_THINGS_QUERY
  include GET_RESPONSE
  
  def get_step_work_packageable_things( step )
    
    # We get the step work packageable things query.
    request_body = step_work_packageable_things_query( step )
    
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We construct an array to hold the work packageable things.
    work_packageable_things = []
  
    # For each row in the CSV ...
    csv.each do |row|
  
      # ... we create a new work packageable thing object ...
      work_packageable_thing = WorkPackageableThing.new
      work_packageable_thing.work_package_identifier = row['workPackage']
      work_packageable_thing.procedure_identifier = row['procedure']
      work_packageable_thing.procedure_label = row['procedureName']
      work_packageable_thing.identifier = row['workPackagedThing']
      work_packageable_thing.label = row['workpackagedThingName']
      work_packageable_thing.event_date = row['businessItemDate'].to_date if row['businessItemDate']
      
      # ... and add it to the array of work packageable things.
      work_packageable_things << work_packageable_thing
    end
  
    # We return the array of work packageable things.
    work_packageable_things
  end
end