module Sparql::Queries::HouseStepCollections

  # A SPARQL query to get step collections for a house.
  def house_step_collections_query( house_id )

    [
          # The title of the SPARQL query.
      'A list of step collections for a House',
      
      # The link to the SPARQL query.
      'https://api.parliament.uk/s/bea0ab86',
      
      # The SPARQL query.
    "
# We declare the Parliament and ID namespaces.
PREFIX : <https://id.parliament.uk/schema/>
PREFIX id: <https://id.parliament.uk/>

# We select the relevant properties we want to appear in results.
# If all properties are required, an asterisk can be used between SELECT and WHERE instead of listing properties.
SELECT * WHERE {
  
  # We find all houses that have a procedure step collection and get the name of the house.
  ?house a :House ;
  :name ?houseName;
  :houseHasProcedureStepCollection ?stepCollection. 

  # We find the name of the step collection.
  ?stepCollection :name ?stepCollectionName.   
  
  # We filter the results to only include step collections for the specified house.
  FILTER (?house IN (id:#{house_id}))
} 

# We order the results by the name of the step collection.
ORDER BY ?stepCollectionName

    "
  ]
  end
end