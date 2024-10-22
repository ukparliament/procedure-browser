module Sparql::Get::StepRoutes
  
  def get_step_routes( step )
    
    # We get the step routes query.
    request_body = step_routes_query( step )
    
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We construct an array to hold the routes.
    routes = []
  
    # For each row in the CSV ...
    csv.each do |row|
  
      # ... we create a new route object ...
      route = Route.new
      route.identifier = row['Route']
      route.start_on = row['startDate'].to_date if row['startDate']
      route.end_on = row['endDate'].to_date if row['endDate']
      route.procedure_identifier = row['procedure']
      route.procedure_label = row['procedureLabel']
      route.from_step_identifier = row['FromStep']
      route.from_step_label = row['FromStepName']
      route.from_step_type_identifier = row['FromStepType']
      route.from_step_type_label = row['FromStepTypeName']
      route.from_step_commons_identifier = row['FromStepCommonsId']
      route.from_step_lords_identifier = row['FromStepLordsId']
      route.from_step_legislature_identifier = row['FromSteplegislature']
      route.from_step_legislature_label = row['FromSteplegislatureName']
      route.to_step_identifier = row['ToStep']
      route.to_step_label = row['ToStepName']
      route.to_step_type_identifier = row['ToStepType']
      route.to_step_type_label = row['ToStepTypeName']
      route.to_step_commons_identifier = row['ToStepCommonsId']
      route.to_step_lords_identifier = row['ToStepLordsId']
      route.to_step_legislature_identifier = row['ToSteplegislature']
      route.to_step_legislature_label = row['ToSteplegislatureName']
      
      # ... and add it to the array of procedures.
      routes << route
    end
  
    # We return the array of routes.
    routes
  end
end