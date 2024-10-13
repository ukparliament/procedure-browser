module Sparql::Queries::Steps

  # A SPARQL query to get all steps.
  def steps_query
    "
      PREFIX id: <https://id.parliament.uk/>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      SELECT ?Step ?stepName ?stepType ?stepTypeName ?legislature ?legislatureName ?CommonsId ?LordsId  WHERE {

        ?Step a :ProcedureStep;
                  :name ?stepName;
                  :procedureStepHasProcedureStepType ?stepType.
        ?stepType :name ?stepTypeName.
      Optional {?Step :procedureStepInLegislature ?legislature.
          ?legislature :name ?legislatureName.}
        Optional {?Step :procedureStepHasHouse ?CommonsId.
              filter (?CommonsId IN (id:1AFu55Hs))}
        Optional {?Step :procedureStepHasHouse ?LordsId.
             filter (?LordsId IN (id:WkUWUBMx))}
      } order by ?stepName ?stepTypeName
    "
  end
end