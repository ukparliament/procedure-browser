module Sparql::Queries::CalculationStyle

  # A SPARQL query to get a calculation style.
  def calculation_style_query( calculation_style_id )
    "
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX id: <https://id.parliament.uk/>
      SELECT * WHERE {
        ?CalculationStyle a :CalculationStyle;
                   :name ?CalculationStyleName.
  filter (?CalculationStyle in (id:#{calculation_style_id}))
              
              } Order by ?CalculationStyleName
    "
  end
end