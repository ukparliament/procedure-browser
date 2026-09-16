module Sparql::Queries::CalculationStyleProcedures

  # A SPARQL query to get procedures for a calculation style.
  def calculation_style_procedures_query( calculation_style_id )
    [
      # The title of the SPARQL query.
      "A list of a calculation style's procedures",

      # The link to the SPARQL query.
      'https://api.parliament.uk/s/b16fcff3',

      # The SPARQL query.
      "
# We declare the Parliament and ID namespaces.    
PREFIX : <https://id.parliament.uk/schema/>
PREFIX id: <https://id.parliament.uk/>

# We select the properties we want to appear in results. 
# If all properties are required, an asterisk can be used between SELECT and WHERE instead of listing properties.
SELECT * WHERE {

  # We find all calculation styles with their names.     
  ?calculationStyle a :CalculationStyle;
  :name ?calculationStyleName.

  # We filter the results to only include the calculation style with ID #{calculation_style_id}.
  FILTER ( ?calculationStyle IN  ( id:#{calculation_style_id} ) )

  # We find all procedures for the calculation style with their names and descriptions.
  ?calculationStyle :calculationStyleHasProcedure ?procedure.
  ?procedure :name ?procedureName.
  ?procedure :procedureDescription ?procedureDescription.
} 

# We order results by calculation style name.
ORDER BY ?calculationStyleName
    "
  ]
  end
end