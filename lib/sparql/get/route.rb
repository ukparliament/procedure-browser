module Sparql::Get::Route

  # A method to get a route.
  def get_route( route_id )
  
    # We get the route query.
    request_body = route_query( route_id )
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We take the one and only row from the CSV ...
    csv.take( 1 ).each do |row|
    
      # ... and create a new route object.
      route = Route.new
      route.identifier = row['Route']
      route.start_on = row['StartDate'].to_date if row['StartDate']
      route.end_on = row['EndDate'].to_date if row['EndDate']
      route.from_step_identifier = row['FromStep']
      route.from_step_label = row['FromStepName']
      route.from_step_type_identifier = row['FromStepType']
      route.from_step_type_label = row['FromStepTypeName']
      route.from_step_legislature_identifier = row['FromSteplegislature']
      route.from_step_legislature_label = row['FromSteplegislatureName']
      route.from_step_commons_identifier = row['FromStepCommonsId']
      route.from_step_lords_identifier = row['FromStepLordsId']
      route.to_step_identifier = row['ToStep']
      route.to_step_label = row['ToStepName']
      route.to_step_type_identifier = row['ToStepType']
      route.to_step_type_label = row['ToStepTypeName']
      route.to_step_legislature_identifier = row['ToSteplegislature']
      route.to_step_legislature_label = row['ToSteplegislatureName']
      route.to_step_commons_identifier = row['ToStepCommonsId']
      route.to_step_lords_identifier = row['ToStepLordsId']
      
      # We return the route object.
      return route
    end
  end
end