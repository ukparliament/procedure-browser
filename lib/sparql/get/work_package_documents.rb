module Sparql::Get::WorkPackageDocuments

  # A method to get all business items in a work package with a link, actualising steps in the reading list collection.
  def get_work_package_documents( work_package_id )
  
    # We get the work package documents query.
    request_body = work_package_documents_query( work_package_id )
  
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
      business_item.commons_identifier = row['commonsId']
      business_item.lords_identifier = row['lordsId']
      business_item.work_packageable_thing_identifier = row['paper']
      business_item.work_packageable_thing_label = row['papername']
      business_item.work_package_identifier = row['workPackage']
      
      # ... and add it to the array of business items.
      business_items << business_item
    end
  
    # We return the array of business items.
    business_items									
  end
end