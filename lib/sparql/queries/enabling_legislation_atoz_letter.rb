module Sparql::Queries::EnablingLegislationAtozLetter

  # A SPARQL query to get a list of enabling legislation starting with a given letter.
  def enabling_legislation_atoz_letter_query( letter )
     [
      # The title of the SPARQL query.
      "Enabling legislation starting with the letter #{letter} ",

      # The link to the SPARQL query.
      'https://api.parliament.uk/s/73bb0b0f',

      # The SPARQL query.
    
    "
# We declare the Parliament and ID namespaces.    
PREFIX : <https://id.parliament.uk/schema/>
PREFIX id: <https://id.parliament.uk/>

# We select the properties we want to appear in results.
# If all properties are required, an asterisk can be used between SELECT and WHERE instead of listing properties.
# Distinct is used to ensure that enabling legislation is not duplicated in the results.
SELECT DISTINCT ?enablingThing ?name ?number ?year ?date ?url WHERE {

# We find all enabling legislation and their associated enabled things.
?enablingThing a :EnablingThing;  
  :enabling ?enabledThing.

  # We specify that the enabling legislation may, or may not, have a name, number, year, royal assent date and URL.
  OPTIONAL { 
    ?enablingThing :actOfParliamentName ?name.
  }
  OPTIONAL { 
    ?enablingThing :actOfParliamentNumber ?number. 
  }
  OPTIONAL { 
    ?enablingThing :actOfParliamentYear ?year. 
  }
  OPTIONAL { 
    ?enablingThing :actOfParliamentRoyalAssentDate ?date. 
  }
  OPTIONAL { 
    ?enablingThing :actOfParliamentUrl ?url. 
  }
  
  # We find the names of the enabled things.
  ?enabledThing :name ?enabledThingName.
  
  # We filter the results to only include enabling legislation with names starting with the letter #{letter}.
  FILTER REGEX(STR(?name), '^#{letter}', 'i')
}

# We order results by enabling legislation name.
ORDER BY ?name
    "
  ]
  end
end
