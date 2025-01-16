module Sparql::Queries::CalculationStyleProcedures

  # A SPARQL query to get procedures for a calculation style.
  def calculation_style_procedures_query( calculation_style_id )
    "
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX id: <https://id.parliament.uk/>
      SELECT * WHERE {
        ?CalculationStyle a :CalculationStyle;
                   :name ?CalculationStyleName.
  filter (?CalculationStyle in (id:#{calculation_style_id}))
    ?CalculationStyle :calculationStyleHasProcedure ?procedure.
   			   ?procedure :name ?procedureName.
  			   ?procedure :procedureDescription ?procedureDescription
              } Order by ?CalculationStyleName
    "
  end
end