module STEP_QUERY

  Sparql::Queries::Step = true

  # A SPARQL query to get a step.
  def step_query( step_id )
    "
      PREFIX id: <https://id.parliament.uk/>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      SELECT ?Step ?stepName  ?description ?scopeNote ?linkNote ?dateNote ?publicationName ?publicationUrl ?stepType ?stepTypeLabel WHERE {

        ?Step a :ProcedureStep;
                  :name ?stepName;
                  :procedureStepHasProcedureStepType ?stepType.
        ?stepType :name ?stepTypeLabel.
        optional { ?Step :procedureStepDescription ?description;
                  :procedureStepHasProcedureStepPublication ?publication;
                  :procedureStepScopeNote ?scopeNote;
                  :procedureStepLinkNote ?linkNote;
                  :procedureStepDateNote ?dateNote.
        ?publication :procedureStepPublicationName ?publicationName;
                     :procedureStepPublicationUrl ?publicationUrl.}

        filter (?Step IN (id:#{step_id})}
    "
  end
end