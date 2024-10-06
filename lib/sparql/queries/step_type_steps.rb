module STEP_TYPE_STEPS_QUERY

  Sparql::Queries::StepTypeSteps = true

  # A SPARQL query to get all steps for a step type.
  def step_type_steps_query( step_type_id )
    "
      PREFIX id: <https://id.parliament.uk/>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      SELECT ?StepType ?stepTypeName ?procedureStep ?procedureStepName WHERE {

        ?StepType a :ProcedureStepType;
                  :name ?stepTypeName;
                  :procedureStepTypeHasProcedureStep ?procedureStep.
                  ?procedureStep :name ?procedureStepName.
        Filter (?StepType in (id:#{step_type_id}))
      }
    "
  end
end