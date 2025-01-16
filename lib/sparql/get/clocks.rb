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
      clock.identifier = row['Clock']
      clock.label = row['ClockName']
      clock.day_count = row['DayCount']
      clock.procedure_identifier = row['procedure']
      clock.procedure_label = row['procedureName']
      clock.from_step_identifier = row['StartStep']
      clock.from_step_label = row['StartStepName']
      clock.from_step_type_identifier = row['StartStepType']
      clock.from_step_type_label = row['StartStepTypeName']
      clock.from_step_legislature_identifier = row['StartSteplegislature']
      clock.from_step_legislature_label = row['StartSteplegislatureName']
      clock.from_step_commons_identifier = row['StartStepCommonsId']
      clock.from_step_lords_identifier = row['StartStepLordsId']
      clock.to_step_identifier = row['EndStep']
      clock.to_step_label = row['EndStepName']
      clock.to_step_type_identifier = row['EndStepType']
      clock.to_step_type_label = row['EndStepTypeName']
      clock.to_step_legislature_identifier = row['EndSteplegislature']
      clock.to_step_legislature_label = row['EndSteplegislatureName']
      clock.to_step_commons_identifier = row['EndStepCommonsId']
      clock.to_step_lords_identifier = row['EndStepLordsId']
      
      # ... and add it to the array of clocks.
      clocks << clock
    end
  
    # We return the array of clocks.
    clocks
  end
end