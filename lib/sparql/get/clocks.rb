module Sparql::Get::Clocks

  # A method to get an array of all clocks.
  def get_clocks

    # We get the clocks query.
    request_body = clocks_query
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
  
    # We construct an array to hold the clocks.
    clocks = []
  
    # For each row in the CSV ...
    csv.each do |row|
  
      # ... we create a new clock object ...
      clock = Clock.new
      clock.identifier = row['clock']
      clock.label = row['clockName']
      clock.day_count = row['dayCount']
      clock.procedure_identifier = row['procedure']
      clock.procedure_label = row['procedureName']
      clock.from_step_identifier = row['startStep']
      clock.from_step_label = row['startStepName']
      clock.from_step_type_identifier = row['startStepType']
      clock.from_step_type_label = row['startStepTypeName']
      clock.from_step_legislature_identifier = row['startSteplegislature']
      clock.from_step_legislature_label = row['startSteplegislatureName']
      clock.from_step_commons_identifier = row['startStepCommonsId']
      clock.from_step_lords_identifier = row['startStepLordsId']
      clock.to_step_identifier = row['endStep']
      clock.to_step_label = row['endStepName']
      clock.to_step_type_identifier = row['endStepType']
      clock.to_step_type_label = row['endStepTypeName']
      clock.to_step_legislature_identifier = row['endSteplegislature']
      clock.to_step_legislature_label = row['endSteplegislatureName']
      clock.to_step_commons_identifier = row['endStepCommonsId']
      clock.to_step_lords_identifier = row['endStepLordsId']
      
      # ... and add it to the array of clocks.
      clocks << clock
    end
    
    # We return the array of clocks.
    clocks
  end
end