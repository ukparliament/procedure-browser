module Sparql::Get::BusinessItemSteps
  
  def get_business_item_steps( business_item_id )
    
    # We get the business item steps query.
    request_body = business_item_steps_query( business_item_id )
    
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
      step.business_item_identifier = row['event']
      step.business_item_date = row['eventDate'].to_date if row['eventDate']
      step.business_item_link = row['url']
      
      # ... and add it to the array of steps.
      steps << step
    end
  
    # We return the array of steps.
    steps
  end
end