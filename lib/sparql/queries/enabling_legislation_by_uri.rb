module Sparql::Queries::EnablingLegislationByUri

  # A SPARQL query to get an item of enabling legislation by its legislation.gov.uk URI.
  def enabling_legislation_by_uri_query( enabling_legislation_uri )
    [
      # The title of the SPARQL query.
      "Lookup of enabling legislation by its legislation.gov.uk URI #{enabling_legislation_uri}",

      # The link to the SPARQL query.
      'https://api.parliament.uk/s/49a8bd46',

      # The SPARQL query.
    "
# We declare the Parliament and ID namespaces.    
PREFIX : <https://id.parliament.uk/schema/>
PREFIX id: <https://id.parliament.uk/>

# We select the properties we want to appear in results.
# If all properties are required, an asterisk can be used between SELECT and WHERE instead of listing properties.
SELECT * WHERE {

  # We find all enabling legislation and their name.
  ?act a :ActOfParliament.
  ?act :actOfParliamentName ?name.

  # We specify that the enabling legislation may, or may not, have a number, year, royal assent date and URL.
  OPTIONAL {
    ?act :actOfParliamentNumber ?number
  }
  OPTIONAL {
    ?act :actOfParliamentYear ?year
  }
  OPTIONAL { 
    ?act :actOfParliamentRoyalAssentDate ?date
  }
  OPTIONAL {
    ?act :actOfParliamentUrl ?url
  }

  # We filter the results to only include enabling legislation with the legislation.gov.uk URI #{enabling_legislation_uri}. 
  FILTER ( ?url='#{ enabling_legislation_uri }'^^xsd:string )
}  
    "
  ]  
  end
end