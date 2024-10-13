module Sparql::Queries::StepTypeSteps

  # A SPARQL query to get all steps for a step type.
  def step_type_steps_query( step_type_id )
    "
      PREFIX id: <https://id.parliament.uk/>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      SELECT ?StepType ?stepTypeName ?StepTypeDescription ?Step ?StepName ?legislature ?legislatureName ?CommonsId ?LordsId WHERE {

        ?StepType a :ProcedureStepType;
                  :name ?stepTypeName;
                  :procedureStepTypeHasProcedureStep ?Step.
        filter (?StepType in (id:#{step_type_id}))
          ?Step :name ?StepName.
        Optional {?Step :procedureStepInLegislature ?legislature.
          ?legislature :name ?legislatureName.}
        Optional {?Step :procedureStepHasHouse ?CommonsId.
              filter (?CommonsId IN (id:1AFu55Hs))}
        Optional {?Step :procedureStepHasHouse ?LordsId.
             filter (?LordsId IN (id:WkUWUBMx))}
        Optional {?StepType :procedureStepTypeDescription ?StepTypeDescription} 
        } order by ?StepName 
    "
  end
end