module Sparql::Queries::EnablingLegislationWorkPackageableThingCount

  # A SPARQL query to get a count of all work packageable things for an item of enabling legislation.
  def enabling_legislation_work_packageable_thing_count_query( enabling_thing_id )
    [
    # The title of the SPARQL query.
      "Count of all work packageable things for enabling legislation with ID #{enabling_thing_id}",

      # The link to the SPARQL query.
      'https://api.parliament.uk/s/55effb57',

      # The SPARQL query.
    "
# We declare the Parliament and ID namespaces.    
PREFIX : <https://id.parliament.uk/schema/>
PREFIX id: <https://id.parliament.uk/>

# We select the properties we want to appear in results.
# If all properties are required, an asterisk can be used between SELECT and WHERE instead of listing properties.
# We count the number of distinct work packageable things for an item of enabling legislation.
SELECT (COUNT(DISTINCT ?workPackagedThing) AS ?count) WHERE {

  # We find all enabling legislation and their names.   
  ?act a :ActOfParliament;
  :actOfParliamentName ?name.

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
  
  # We filter the results to only include enabling legislation with ID #{enabling_thing_id}.
  FILTER ( ?act IN ( id:#{enabling_thing_id} ) )

  # We find all work packaged things of the enabling legislation and their names.
  ?act :enabling ?workPackagedThing. 
  ?workPackagedThing :name ?workPackagedThingName. 
  }                      
       
    "
  ]
  end
end
