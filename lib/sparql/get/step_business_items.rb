module Sparql::Get::StepBusinessItems
  
  def get_step_business_items( step, page_number, results_per_page )
  
    # We calculate the result offset.
    result_offset = ( ( page_number - 1) * results_per_page )
  
    # We get the step business items query.
    request_body = step_business_items_query( step, results_per_page, result_offset )
    
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
      business_item.work_package_identifier = row['workPackage']
      business_item.work_packageable_thing_label = row['workpackagedThingName']
      business_item.procedure_identifier = row['procedure']
      business_item.procedure_label = row['procedureName']
      
      # ... and add it to the array of business items.
      business_items << business_item
    end
  
    # We return the array of business items.
    business_items
  end
end