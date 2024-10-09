module STEP_QUERY

  Sparql::Queries::Step = true

  # A SPARQL query to get a step.
  def step_query( step_id )
    "
      PREFIX id: <https://id.parliament.uk/>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      SELECT ?Step ?stepName  ?description ?scopeNote ?linkNote ?dateNote ?publicationName ?publicationUrl ?stepType ?stepTypeLabel ?CommonsId ?LordsId ?legislature ?legislatureName WHERE {

        ?Step a :ProcedureStep;
                  :name ?stepName;
                  :procedureStepHasProcedureStepType ?stepType.
        ?stepType :name ?stepTypeLabel.
        optional { ?Step :procedureStepDescription ?description}
        optional {?Step  :procedureStepHasProcedureStepPublication ?publication.
        ?publication :procedureStepPublicationName ?publicationName;
        :procedureStepPublicationUrl ?publicationUrl.}
        optional {?Step  :procedureStepScopeNote ?scopeNote}
        optional {?Step  :procedureStepLinkNote ?linkNote}
        optional {?Step  :procedureStepDateNote ?dateNote}
         optional {?Step :procedureStepInLegislature ?legislature.
          ?legislature :name ?legislatureName.}
        optional {?Step :procedureStepHasHouse ?CommonsId.
              filter (?CommonsId IN (id:1AFu55Hs))}
        optional {?Step :procedureStepHasHouse ?LordsId.
             filter (?LordsId IN (id:WkUWUBMx))}
        filter (?Step IN (id:#{step_id}))}
    "
  end
end