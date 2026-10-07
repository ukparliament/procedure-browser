module Sparql::Queries::EnablingLegislationAtoz

  # A SPARQL query to get an A to Z of enabling legislation.
  def enabling_legislation_atoz_query
    [
      # The title of the SPARQL query.
      "List of initial letters of legislation having enabled instruments",

      # The link to the SPARQL query.
      'https://shortener120181217063232.azurewebsites.net/s/09d57f7f',

      # The SPARQL query.
    "
# We declare the Parliament and ID namespaces.    
PREFIX : <https://id.parliament.uk/schema/>
PREFIX id: <https://id.parliament.uk/>

# We select the properties we want to appear in results.
# If all properties are required, an asterisk can be used between SELECT and WHERE instead of
SELECT ?firstLetter WHERE {

  # We find all enabling legislation and their associated enabled things.  
  ?enablingThing a :EnablingThing;
  :enabling ?enabledThing.
  
  # We specify that the enabling legislation may, or may not, have a name.
  OPTIONAL { ?enablingThing :actOfParliamentName ?name. }

  # We filter the results to only include enabling legislation with names that are not empty and only use their first letter.
  BIND(UCASE(SUBSTR(STR(?name), 1, 1)) AS ?firstLetter)
}

# We group results by first letter of enabling legislation name and order them alphabetically.
# This ensures that each letter is only returned once in the results.
GROUP BY ?firstLetter
ORDER BY ?firstLetter
    "
  ]
  end
end
