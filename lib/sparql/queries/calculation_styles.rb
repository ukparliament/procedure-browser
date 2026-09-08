module Sparql::Queries::CalculationStyles

  # A SPARQL query to get all calculation styles.
  def calculation_styles_query
    [
      # The title of the SPARQL query.
      "A list of calculation styles",

      # The link to the SPARQL query.
      'https://api.parliament.uk/s/02c240f0',

      # The SPARQL query.
    "
# We declare the Parliament and ID namespaces.
PREFIX : <https://id.parliament.uk/schema/>
PREFIX id: <https://id.parliament.uk/>

# We select all properties returned.
SELECT * WHERE {

  # We find all calculation styles with their names.  
  ?calculationStyle a :CalculationStyle;
  :name ?calculationStyleName.
} 

# We order results by calculation style name.
ORDER BY ?calculationStyleName
    "
  ]
  end
end