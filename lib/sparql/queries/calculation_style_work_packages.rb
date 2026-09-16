module Sparql::Queries::CalculationStyleWorkPackages

  # A SPARQL query to get work packages for a calculation style.
  def calculation_style_work_packages_query( calculation_style_id, limit, offset )
    [
      # The title of the SPARQL query.
      "A list of a calculation style's work packages with offset and limit for pagination",

      # The link to the SPARQL query.
      'https://api.parliament.uk/s/1992aa49',

      # The SPARQL query.
    "
# We declare the Parliament and ID namespaces.
PREFIX : <https://id.parliament.uk/schema/>
PREFIX id: <https://id.parliament.uk/>
              
# We select the properties we want to appear in results.
# If all properties are required, an asterisk can be used between SELECT and WHERE instead of listing properties.
# Distinct is used to ensure that work packages are not duplicated in the results.
SELECT DISTINCT ?calculationStyle ?calculationStyleName ?workPackage ?combinedDate ?workPackagedThing ?workPackagedThingName ?procedure ?procedureName (BOUND(?stepId3) AS ?hasCommitteeConcernsFlag)   
(BOUND(?stepId4) AS ?hasMotionTabledFlag) WHERE {

  # We find all calculation styles with their names and work packages.   
  ?calculationStyle a :CalculationStyle;
  :name ?calculationStyleName;
  :calculationStyleHasWorkPackage ?workPackage.

  # We filter the results to only include the calculation style with ID #{calculation_style_id}.
  FILTER ( ?calculationStyle IN ( id:#{calculation_style_id} ) )

  # We find the work packaged things of the work packages and their names.
  ?workPackage :workPackageHasWorkPackagedThing ?workPackagedThing.
  ?workPackagedThing :name ?workPackagedThingName. 

  # We find the procedure of the work packages and the procedure names.
  ?workPackage :workPackageHasProcedure ?procedure.
  ?procedure :name ?procedureName.
  
  # We find the making available business item, if there is one, of the work packages and it's date.
  OPTIONAL {
    ?workPackage :workPackageHasBusinessItem ?businessItem .
    ?businessItem :businessItemHasProcedureStep ?step;
    :businessItemDate ?businessItemDate.
    # We filter business items that actualise steps set out as making available steps such as 'Laid before the House of Commons'.
    FILTER ( ?step IN ( id:isWn7s3K, id:cspzmb6w, id:ITNO9JWr, id:otscOTzB ) )
  }
  
  # Some work packages have one or more available business items in one work package, one being earlier than the other.
  # We find the earliest available business item, if there is one, of the work packages and it's date.
  OPTIONAL {
    ?workPackage :workPackageHasBusinessItem ?businessItem2 .
    ?businessItem2 :businessItemHasProcedureStep ?step2;
    :businessItemDate ?businessItemDate2.
    # We filter business items that actualise the 'Brought to the attention of Parliament' step which may be the earliest available business item of a work package in the treaties procedure.
    FILTER ( ?step2 IN (id:AmYrFxwO) )
  }
  
  # We check to see if the work package has a business item with a step in the 'Committee concerns' collection.
  OPTIONAL {
    ?workPackage :workPackageHasBusinessItem ?bi3 .
    ?bi3 :businessItemHasProcedureStep ?stepId3 .
    ?stepId3 :procedureStepHasProcedureStepCollectionMembership/
    :procedureStepCollectionMembershipHasProcedureStepCollection id:7CBVQcZF
  }

  # We check to see if the work package has a business item with a step in the 'Motions tabled' collection.
  OPTIONAL {
    ?workPackage :workPackageHasBusinessItem ?bi4 .
    ?bi4 :businessItemHasProcedureStep ?stepId4 .
    ?stepId4 :procedureStepHasProcedureStepCollectionMembership/
    :procedureStepCollectionMembershipHasProcedureStepCollection id:l3g2umNB
  }

  # We combine the two business item dates into one date for ordering purposes.  
  BIND(COALESCE(?businessItemDate, ?businessItemDate2) AS ?combinedDate)
} 

# We order results by the combined date of the making available business items, with the most recent first, and then by the name of the work packaged thing.
ORDER BY DESC(?combinedDate) ?workPackagedThingName

# We limit the number of results returned and offset the results by a certain number for pagination purposes.
LIMIT #{limit} OFFSET #{offset}
    "
    ]  
  end
end