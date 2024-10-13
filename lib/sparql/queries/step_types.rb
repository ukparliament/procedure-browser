module Sparql::Queries::StepTypes

  # A SPARQL query to get all step types.
  def step_types_query
    "
      PREFIX id: <https://id.parliament.uk/>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      SELECT ?StepType ?stepTypeName  WHERE {

        ?StepType a :ProcedureStepType;
                  :name ?stepTypeName.

      } order by asc(UCASE(str(?stepTypeName)))
    "
  end
end