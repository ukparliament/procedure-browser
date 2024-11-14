module Sparql::Get::EventSteps
  
  def get_event_steps( event )
    
    # We get the event steps query.
    request_body = event_steps_query( event )
    
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We construct an array to hold the steps.
    steps = []
  
    # For each row in the CSV ...
    csv.each do |row|
  
      # ... we create a new step object ...
      step = Step.new
      step.identifier = row['step']
      step.label = row['stepName']
      step.step_label = row['stepName']
      step.legislature_identifier = row['legislature']
      step.legislature_label = row['legislatureName']
      step.commons_identifier = row['CommonsId']
      step.lords_identifier = row['LordsId']
      step.event_date = row['eventDate'].to_date if row['eventDate']
      step.event_link = row['url']
      
      # ... and add it to the array of events.
      steps << step
    end
  
    # We return the array of events.
    steps
  end
end