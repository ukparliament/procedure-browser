module Sparql::Queries::EnablingLegislation

  # A SPARQL query to get an item of enabling legislation.
  def enabling_legislation_query( enabling_legislation_id )
[
    # The title of the SPARQL query.
      "An enabling legislation",

      # The link to the SPARQL query.
      'https://api.parliament.uk/s/c1ab5e0f',

      # The SPARQL query.

    "
# We declare the Parliament and ID namespaces.    
PREFIX : <https://id.parliament.uk/schema/>
PREFIX id: <https://id.parliament.uk/>

# We select the properties we want to appear in results.
# If all properties are required, an asterisk can be used between SELECT and WHERE instead of listing properties.
SELECT * WHERE {
  
  # We find all enabling legislation and their names.
  ?act a :ActOfParliament.
  ?act :actOfParliamentName ?name.

  # We specify that the enabling legislation may, or may not, have a number, year, royal assent date and URL.
  OPTIONAL {
    ?act :actOfParliamentNumber ?number
  }
  OPTIONAL {
    ?act :actOfParliamentYear ?year
  }
  OPTIONAL{  
    ?act :actOfParliamentRoyalAssentDate ?date
  }
  OPTIONAL {
    ?act :actOfParliamentUrl ?url
  }

  # We filter the results to only include enabling legislation with ID #{enabling_legislation_id}.
  FILTER ( ?act IN ( id:#{enabling_legislation_id} ) )

}                      
           
    "

  ]
  end
end