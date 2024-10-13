module Sparql::Queries::StepType

  # A SPARQL query to get a step type.
  def step_type_query( step_type_id )
    "
      PREFIX id: <https://id.parliament.uk/>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      SELECT ?StepType ?stepTypeName ?stepTypeDescription  WHERE {

        ?StepType a :ProcedureStepType;
                  :name ?stepTypeName.
        OPTIONAL {   ?StepType         :procedureStepTypeDescription ?stepTypeDescription.}
        Filter (?StepType in (id:#{step_type_id}))
      }
    "
  end
end



