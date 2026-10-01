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
        
        # We return the clock object.
        return clock
      end
    end
  end
end