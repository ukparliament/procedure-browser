module Sparql::Get::Routes

  # A method to get an array of all routes.
  def get_routes

    # We get the routes query.
    request_body = routes_query
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
  
    # We construct an array to hold the routes.
    routes = []
  
    # For each row in the CSV ...
    csv.each do |row|
  
      # ... we create a new route object ...
      route = Route.new
      route.identifier = row['Route']
      route.procedure_identifier = row['Procedure']
      route.procedure_label = row['procedureName']
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
      
      # ... and add it to the array of routes.
      routes << route
    end
  
    # We return the array of routes.
    routes
  end
end