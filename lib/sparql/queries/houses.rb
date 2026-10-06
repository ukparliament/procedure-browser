module Sparql::Queries::Houses

  # A SPARQL query to get all Houses.
  def houses_query
    [
          # The title of the SPARQL query.
      'A list of Houses',
      
      # The link to the SPARQL query.
      'https://api.parliament.uk/s/5c232d58',
      
      # The SPARQL query.
    "
# We declare the Parliament and ID namespaces.
PREFIX : <https://id.parliament.uk/schema/>
PREFIX id: <https://id.parliament.uk/>

# We select the relevant properties we want to appear in results.
# If all properties are required, an asterisk can be used between SELECT and WHERE instead of listing properties.
SELECT * WHERE { 

  # We find all houses and get the name of the house.
  ?house a :House ;
  :name ?houseName. 
} 

# We order the results by the name of the house.
ORDER BY ?houseName
    "
  ]
  end
end