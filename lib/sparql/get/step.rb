module Sparql::Get::Step

  # A method to get a step.
  def get_step( step_id )
  
    # We get the all step query.
    request_body = step_query( step_id )
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # If the step doesn't exist, the csv will be an empty array.
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
    
        # ... and create a new step object.
        step = Step.new
        step.identifier = row['Step']
        step.label = row['stepName']
        step.description = row['description']
        step.scope_note = row['scopeNote']
        step.link_note = row['linkNote']
        step.date_note = row['dateNote']
        step.publication_name = row['publicationName']
        step.publication_url = row['publicationUrl']
        step.step_type_identifier = row['stepType']
        step.step_type_label = row['stepTypeLabel']
        step.commons_identifier = row['CommonsId']
        step.lords_identifier = row['LordsId']
        step.legislature_identifier = row['legislature']
        step.legislature_label = row['legislatureName']
      
        # We return the step object.
        return step
      end
    end
  end
end