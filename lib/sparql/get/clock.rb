module Sparql::Get::Clock

  # A method to get a clock.
  def get_clock( clock_id )
  
    # We get the clock query.
    request_body = clock_query( clock_id )
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # If the clock doesn't exist, the csv will be an empty array.
    # If the array is an empty array ...
    if csv.empty?
      
      # ... we render a 404 ...
      render_404
      
      # ... and return nil.
      return nil
      
    # Otherwise, if the CSV is not an empty array ...
    else
    
      # ... we take the one and only row from the CSV ...
      csv.take( 1 ).each do |row|
    
        # ... and create a new clock object.
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
      
        # We return the clock object.
        return clock
      end
    end
  end
end