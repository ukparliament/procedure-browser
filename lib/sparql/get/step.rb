# We require the module files for the step query and the SPARQL response.
require 'sparql/queries/step'
require 'sparql/get/response'

module GET_STEP

  Sparql::Get::Step = true
  
  # We include the step query and SPARQL response modules.
  include STEP_QUERY
  include GET_RESPONSE

  # A method to get a step.
  def get_step( step_id )
  
    # We get the all step query.
    request_body = step_query( step_id )
  
    # We get the SPARQL response as a CSV.
    csv = get_sparql_response_as_csv( request_body )
    
    # We take the one and only row from the CSV ...
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