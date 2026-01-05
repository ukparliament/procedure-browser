module Sparql::Get::BusinessItemSteps
  
  def get_business_item_steps( business_item_id )
    
    # We get the business item steps query.
    request_body = business_item_steps_query( business_item_id )
    
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # If the enabling legislation doesn't exist, the csv will be an empty array.
    # If the array is an empty array ...
    if csv.empty?
      
      # ... we render a 404 ...
      render_404
      
      # ... and return nil.
      return nil
      
    # Otherwise, if the CSV is not an empty array ...
    else
    
      # ... we construct an array to hold the steps.
      steps = []
  
      # For each row in the CSV ...
      csv.each do |row|
    
        # ... we create a new step object ...
        step = Step.new
        step.identifier = row['businessItemstep']
        step.label = row['businessItemStepName']
        step.step_label = row['businessItemStepName']
        step.legislature_identifier = row['legislature']
        step.legislature_label = row['legislatureName']
        step.commons_identifier = row['CommonsId']
        step.lords_identifier = row['LordsId']
        step.business_item_identifier = row['businessItem']
        step.business_item_date = row['Date'].to_date if row['Date']
        step.business_item_link = row['url']
        step.work_package_identifier = row['workPackage']
        step.work_package_made_available_on = row['madeAvailableDate']
        step.work_packageable_thing_identifier = row['workPackagedThing']
        step.work_packageable_thing_label = row['workPackagedThingLabel']
        step.procedure_identifier = row['procedure']
        step.procedure_label = row['procedureLabel']
        step.calculation_style_identifier = row['calculationStyle']
        step.calculation_style_label = row['calculationStyleLabel']
      
        # ... and add it to the array of steps.
        steps << step
      end
  
      # We return the array of steps.
      steps
    end
  end
end