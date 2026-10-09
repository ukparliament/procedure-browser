module Sparql::Queries::House

  # A SPARQL query to get a House.
  def house_query( house_id )
    [
          # The title of the SPARQL query.
      'A House',
      
      # The link to the SPARQL query.
      'https://api.parliament.uk/s/dfdf874b',
      
      # The SPARQL query.
    "
# We declare the Parliament and ID namespaces.
PREFIX : <https://id.parliament.uk/schema/>
PREFIX id: <https://id.parliament.uk/>

# We select the relevant properties we want to appear in results.
# If all properties are required, an asterisk can be used between SELECT and WHERE instead of listing properties.
SELECT * WHERE { 
   
  # We find all houses and get the name of the house and the legislature it belongs to.  
  ?house a :House ;
  :name ?houseName;
  :houseInLegislature ?legislature.

  # We find the name of the legislature.
  ?legislature :name ?legislatureName. 

  # We filter the results to only include the specified house.
  FILTER ( ?house IN ( id:#{house_id} ) )
} 
    "
  ]
  end
end