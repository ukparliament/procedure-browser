module Sparql::Queries::CalculationStyle

  # A SPARQL query to get a calculation style.
  def calculation_style_query( calculation_style_id )
    [
      # The title of the SPARQL query.
      "A calculation style",

      # The link to the SPARQL query.
      'https://api.parliament.uk/s/a867eef6',

      # The SPARQL query.
    "
# We declare the Parliament and ID namespaces.      
PREFIX : <https://id.parliament.uk/schema/>
PREFIX id: <https://id.parliament.uk/>

# We select all properties.
SELECT * WHERE {

  # We find all calculation styles with their names and egg timer IDs.
  ?calculationStyle a :CalculationStyle;
  :name ?calculationStyleName;
  :calculationStyleEggTimerId ?eggTimerId.

  # We filter the results to only include the calculation style with ID #{calculation_style_id}.
  FILTER ( ?calculationStyle IN ( id:#{calculation_style_id} ) )          
} 

# We order results by calculation style name.  
ORDER BY ?calculationStyleName
    "
  ]
  end
end