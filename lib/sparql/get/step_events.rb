module Sparql::Get::StepEvents
  
  def get_step_events( step )
    
    # We get the step events query.
    request_body = step_events_query( step )
    
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We construct an array to hold the events.
    events = []
  
    # For each row in the CSV ...
    csv.each do |row|
  
      # ... we create a new event object ...
      event = Event.new
      event.identifier = row['businessItem']
      event.date = row['businessItemDate'].to_date if row['businessItemDate']
      event.work_package_identifier = row['workPackage']
      event.work_packageable_thing_label = row['workpackagedThingName']
      event.procedure_identifier = row['procedure']
      event.procedure_label = row['procedureName']
      
      # ... and add it to the array of events.
      events << event
    end
  
    # We return the array of events.
    events
  end
end