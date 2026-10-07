module Sparql::Queries::EnablingLegislationWorkPackageableThings

  # A SPARQL query to get work packageable things enabled by an item of legislation.
  def enabling_legislation_work_packageable_things_query( enabling_thing_id, limit, offset )
    [
    # The title of the SPARQL query.
      "Work packageable things for enabling legislation with ID #{enabling_thing_id}",

      # The link to the SPARQL query.
      'https://api.parliament.uk/s/892c341a',

      # The SPARQL query.
    "
# We declare the Parliament and ID namespaces.    
PREFIX : <https://id.parliament.uk/schema/>
PREFIX id: <https://id.parliament.uk/>
      
# We select the properties we want to appear in results.
# If all properties are required, an asterisk can be used between SELECT and WHERE instead of listing properties.
SELECT ?workPackagedThing ?workPackagedThingName ?businessItemDate ?procedure ?procedureName WHERE {

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
  
  # We filter the results to only include enabling legislation with ID #{enabling_thing_id}.
  FILTER ( ?act IN ( id:#{enabling_thing_id} ) )
  
  # We find all work packaged things of the enabling legislation and their names, and the work packages of the work packaged things.
  ?act :enabling ?workPackagedThing. 
  ?workPackagedThing :name ?workPackagedThingName;
  :workPackagedThingHasWorkPackage ?workPackage.
  
  # We find the making available business item, if there is one, of the work packages and it's date.
  OPTIONAL {
    ?workPackage :workPackageHasBusinessItem ?businessItem .
    ?businessItem :businessItemHasProcedureStep ?step;
    :businessItemDate ?businessItemDate.
    FILTER ( ?step IN ( id:isWn7s3K, id:cspzmb6w, id:ITNO9JWr, id:otscOTzB ) )
  }
  
  # We find the procedure of the work packages and the procedure names.
  ?workPackage :workPackageHasProcedure ?procedure.
  ?procedure :name ?procedureName.
                     
} 
# We order the results by business item date in descending order.  
ORDER BY DESC(?businessItemDate)          
# We limit the number of results returned and we offset the results returned by a specified number.          
LIMIT #{limit} OFFSET #{offset}
    "
  ]   
  end
end