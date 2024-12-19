module Sparql::Queries::CalculationStyles

  # A SPARQL query to get all calculation styles.
  def calculation_styles_query
    "
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX id: <https://id.parliament.uk/>
      SELECT * WHERE {
        ?CalculationStyle a :CalculationStyle;
                   :name ?CalculationStyleName.
              
              } Order by ?CalculationStyleName
    "
  end
end