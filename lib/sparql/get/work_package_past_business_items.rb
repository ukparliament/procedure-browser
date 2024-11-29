module Sparql::Get::WorkPackagePastBusinessItems

  # A method to get a work package and its past business items.
  def get_work_package_past_business_items( work_package_id )
  
    # We get the work package past business items query.
    request_body = work_package_past_business_items_query( work_package_id )
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We construct an array to hold the business items.
    business_items = []
  
    # For each row in the CSV ...
    csv.each do |row|
  
      # ... we create a new business item object ...
      business_item = BusinessItem.new
      business_item.identifier = row['businessItem']
      business_item.date = row['businessItemDate'].to_date if row['businessItemDate']
      business_item.link = row['businessItemLink']
      business_item.step_identifier = row['businessItemProcedureStep']
      business_item.step_label = row['businessItemProcedureStepName']
      business_item.legislature_identifier = row['legislature']
      business_item.legislature_label = row['legislatureName']
      business_item.commons_identifier = row['CommonsId']
      business_item.lords_identifier = row['LordsId']
      business_item.work_packageable_thing_identifier = row['Paper']
      business_item.work_packageable_thing_label = row['Papername']
      business_item.work_package_identifier = row['workPackage']
      business_item.procedure_identifier = row['procedure']
      
      # ... and add it to the array of business items.
      business_items << business_item
    end
  
    # We return the array of business items.
    business_items									
  end
end