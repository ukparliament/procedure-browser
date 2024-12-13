module Sparql::Get::ProcedureStepBusinessItems
  
  def get_procedure_step_business_items( procedure, step )
    
    # We get the procedure step business items query.
    request_body = procedure_step_business_items_query( procedure, step )
    
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We construct an array to hold the business items.
    business_items = []
  
    # For each row in the CSV ...
    csv.each do |row|
  
      # ... we create a new business item object ...
      business_item = BusinessItem.new
      business_item.identifier = row['businessItem']
      business_item.date = row['businessItemDate']
      business_item.link = row['businessItemLink']
      
      business_item.work_package_identifier = row['workPackage']
      business_item.work_packageable_thing_identifier = row['workPackagedThing']
      business_item.work_packageable_thing_label = row['workPackagedThingName']
      business_item.work_package_made_available_on = row['workPackageMadeAvailableOn']
      
      business_item.procedure_identifier = row['Procedure']
      business_item.procedure_label = row['ProcedureName']
      business_item.step_identifier = row['step']
      business_item.step_label = row['stepName']
      business_item.legislature_identifier = row['legislature']
      business_item.legislature_label = row['legislatureName']
      business_item.commons_identifier = row['CommonsId']
      business_item.lords_identifier = row['LordsId']
      
      # ... and add it to the array of business items.
      business_items << business_item
    end
  
    # We return the array of business items.
    business_items
  end
end