module STEPS_QUERY

  Sparql::Queries::Steps = true

  # A SPARQL query to get all steps.
  def steps_query
    "
      PREFIX id: <https://id.parliament.uk/>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      SELECT ?Step ?stepName  WHERE {

        ?Step a :ProcedureStep;
                  :name ?stepName.

      } order by asc(UCASE(str(?stepName)))
    "
  end
end