module Sparql::Queries::CalculationStyleWorkPackageCount

  # A SPARQL query to get a count of all work packages with a given calculation style.
  def calculation_style_work_package_count_query( calculation_style_id )
[
      # The title of the SPARQL query.
      "A count of all of a calculation style's work packages",

      # The link to the SPARQL query.
      'https://api.parliament.uk/s/b9dfb006',

      # The SPARQL query.
    "
# We declare the Parliament and ID namespaces.    
PREFIX : <https://id.parliament.uk/schema/>
PREFIX id: <https://id.parliament.uk/>

# We select the properties we want to appear in results.
# If all properties are required, an asterisk can be used between SELECT and WHERE instead of listing properties.
# We count the number of distinct work packages for a calculation style.
SELECT ( COUNT( DISTINCT ?workPackage ) AS ?count ) WHERE {

  # We find all calculation styles with their names and work packages.
  # We exclude calculation styles that have no work packages.
  ?calculationStyle a :CalculationStyle;
  :name ?calculationStyleName;
  :calculationStyleHasWorkPackage ?workPackage.

  # We filter the results to only include the calculation style with ID #{calculation_style_id}.
  FILTER ( ?calculationStyle IN ( id:#{calculation_style_id} ) )

  # We find the work packaged things of the work packages and their names.
  ?workPackage :workPackageHasWorkPackagedThing ?workPackagedThing.
  ?workPackagedThing :name ?workPackagedThingName. 

  # We find the making available business item, if there is one, of the work packages and it's date. 
  OPTIONAL {
    ?workPackage :workPackageHasBusinessItem ?businessItem .
    ?businessItem :businessItemHasProcedureStep ?step;
    :businessItemDate ?madeAvailableDate.
    FILTER ( ?step IN ( id:isWn7s3K, id:cspzmb6w, id:ITNO9JWr, id:otscOTzB ) )
  }

  # We find the procedure of the work packages and the procedure names.
  ?workPackage :workPackageHasProcedure ?procedure.
  ?procedure :name ?procedureName.

}
    "
  ]
  end
end