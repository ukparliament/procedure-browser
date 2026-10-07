module Sparql::Queries::EnablingLegislations

  # A SPARQL query to get all enabling legislation taking parameters of limit and offset.
  def enabling_legislations_query

    [
          # The title of the SPARQL query.
      'A list of legislation enabling instruments',
      
      # The link to the SPARQL query.
      'https://api.parliament.uk/s/3db888af',
      
      # The SPARQL query.
    "

# We declare the Parliament and ID namespaces.
PREFIX : <https://id.parliament.uk/schema/>
PREFIX id: <https://id.parliament.uk/>

# We select the relevant properties we want to appear in results.
# If all properties are required, an asterisk can be used between SELECT and WHERE instead of listing properties.
# We use DISTINCT to ensure that each enabling thing is only returned once, even if it enables multiple things.
SELECT DISTINCT ?enablingThing ?name ?number ?year ?date ?url WHERE {
  
  # We find all enabling things that enable one or more things.
  ?enablingThing a :EnablingThing;  
  :enabling ?enabledThing.
  
  # We specify that an enabling thing might have a name, number, year, date and url but is not required to have any of those properties. 
  OPTIONAL { 
    ?enablingThing  :actOfParliamentName ?name
  }

  OPTIONAL {
    ?enablingThing :actOfParliamentNumber ?number
  }

  OPTIONAL {
    ?enablingThing:actOfParliamentYear ?year
  }

  OPTIONAL {
    ?enablingThing :actOfParliamentRoyalAssentDate ?date
  }

  OPTIONAL {
    ?enablingThing :actOfParliamentUrl ?url
   }
} 

# We order the results by the name of the enabling thing. 
ORDER BY ?name
    "

  ]   
  end
end
