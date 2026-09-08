module Sparql::Queries::CalculationStyleWorkPackageCountCurrent

  # A SPARQL query to get a count of current work packages with a given calculation style.
  def calculation_style_work_package_count_current_query( calculation_style_id )
    [
      # The title of the SPARQL query.
      "A count of a calculation style's current work packages",

      # The link to the SPARQL query.
      'https://api.parliament.uk/s/f6ee939f',

      # The SPARQL query.
          "

# We declare the Parliament and ID namespaces.
PREFIX : <https://id.parliament.uk/schema/>
PREFIX id: <https://id.parliament.uk/>

# We select the properties we want to appear in results. 
# If all properties are required, an asterisk can be used between SELECT and WHERE instead of listing properties.
# We count the number of distinct work packages for a calculation style, excluding work packages that have business items with steps in the 'Procedure concluded' collection.
SELECT ( COUNT( DISTINCT ?workPackage ) AS ?count ) WHERE {

  # We find all calculation styles with their names and work packages.
  # We exclude calculation styles that have no work packages.
  ?calculationStyle a :CalculationStyle;
  :name ?calculationStyleName;
  :calculationStyleHasWorkPackage ?workPackage.

  # We filter the results to only include the calculation style with ID #{calculation_style_id}.
  FILTER ( ?calculationStyle IN ( id:#{calculation_style_id} ))

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

  # We exclude work packages that have business items with steps in the 'Procedure concluded' collection.
  # This limits results to work packages that are currently before Parliament.
  MINUS {  
    ?workPackage   :workPackageHasBusinessItem ?bi2.
    ?bi2 :businessItemHasProcedureStep ?stepId2.
    ?stepId2 :procedureStepHasProcedureStepCollectionMembership/:procedureStepCollectionMembershipHasProcedureStepCollection id:TRohjSuI
  }

}    
    "
  ]
  end
end