module Sparql::Get::WorkPackageableThingEnablingLegislations
  
  # A method to get an array of all enabling legislation for a work packageable thing.
  def get_work_packageable_thing_enabling_legislation( work_packageable_thing_id )
  
    # We get the work packageable enabling legislations query.
    request_body = work_packageable_thing_enabling_legislations_query( work_packageable_thing_id )
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
  
    # We construct an array to hold the enabling legislation.
    enabling_legislations = []
  
    # For each row in the CSV ...
    csv.each do |row|
  
      # ... we create a new enabling legislation object ...
      enabling_legislation = EnablingLegislation.new
      enabling_legislation.identifier = row['EnablingThing']
      enabling_legislation.label = row['ActName']
      enabling_legislation.date = row['RoyalAssentDate'].to_date if row['RoyalAssentDate']
      enabling_legislation.year = row['Year']
      enabling_legislation.act_number = row['Number']
      
      # ... and add it to the array of enabling legislation.
      enabling_legislations << enabling_legislation
    end
  
    # We return the array of enabling legislation.
    enabling_legislations
  end
end