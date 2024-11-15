module Sparql::Get::WorkPackagePastEvents

  # A method to get a work package and its past events.
  def get_work_package_past_events( work_package_id )
  
    # We get the work package past events query.
    request_body = work_package_past_events_query( work_package_id )
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We construct an array to hold the events.
    events = []
  
    # For each row in the CSV ...
    csv.each do |row|
  
      # ... we create a new event object ...
      event = Event.new
      event.identifier = row['event']
      event.date = row['eventDate'].to_date if row['eventDate']
      event.link = row['eventLink']
      event.step_identifier = row['eventProcedureStep']
      event.step_label = row['eventProcedureStepName']
      event.legislature_identifier = row['legislature']
      event.legislature_label = row['legislatureName']
      event.commons_identifier = row['CommonsId']
      event.lords_identifier = row['LordsId']
      event.work_packageable_thing_identifier = row['Paper']
      event.work_packageable_thing_label = row['Papername']
      event.work_package_identifier = row['workPackage']
      event.procedure_identifier = row['procedure']
      
      # ... and add it to the array of events.
      events << event
    end
  
    # We return the array of events.
    events									
  end
end