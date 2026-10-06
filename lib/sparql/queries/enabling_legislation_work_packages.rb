module Sparql::Queries::EnablingLegislationWorkPackages

  # A SPARQL query to get work packages enabled by an item of legislation.
  def enabling_legislation_work_packages_query( enabling_thing_id, limit, offset )

    [
    # The title of the SPARQL query.
      "Current work packages for enabling legislation with ID #{enabling_thing_id} for pagination",

      # The link to the SPARQL query.
      'https://api.parliament.uk/s/a1220cd1',

      # The SPARQL query.
    "
# We declare the Parliament and ID namespaces.
PREFIX : <https://id.parliament.uk/schema/>
PREFIX id: <https://id.parliament.uk/>

# We select the properties we want to appear in results.
# If all properties are required, an asterisk can be used between SELECT and WHERE instead of listing properties.
# We use DISTINCT to ensure that each work package is only returned once, even if it has multiple business items.
SELECT DISTINCT ?workPackage ?workPackagedThing ?workPackagedThingName ?combinedDate ?procedure ?procedureName ?calculationStyle ?calculationStyleName (BOUND(?stepId3) AS ?hasCommitteeConcernsFlag)   
(BOUND(?stepId4) AS ?hasMotionTabledFlag)  WHERE {
  
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
  OPTIONAL {
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
    FILTER ( ?step2 IN ( id:AmYrFxwO ) ) 
  }
  
  # We find the procedure of the work packages and the procedure name.
  ?workPackage :workPackageHasProcedure ?procedure.
  ?procedure :name ?procedureName.
  
  # We find the calculation style of the work packages and the calculation style name, if there is one.
  OPTIONAL { 
    ?workPackage :workPackageHasCalculationStyle ?calculationStyle. 
    ?calculationStyle :name ?calculationStyleName. 
  }
  
  # We find the business items of the work packages that have a procedure step in the 'Committee concerns' collection and bind a flag to indicate if there are any.
  OPTIONAL {
    ?workPackage :workPackageHasBusinessItem ?bi3 .
    ?bi3 :businessItemHasProcedureStep ?stepId3 .
    ?stepId3 :procedureStepHasProcedureStepCollectionMembership/
    :procedureStepCollectionMembershipHasProcedureStepCollection id:7CBVQcZF
  }
  
  # We find the business items of the work packages that have a procedure step in the 'Motion tabled' collection and bind a flag to indicate if there are any.
  OPTIONAL {
    ?workPackage :workPackageHasBusinessItem ?bi4 .
    ?bi4 :businessItemHasProcedureStep ?stepId4 .
    ?stepId4 :procedureStepHasProcedureStepCollectionMembership/
    :procedureStepCollectionMembershipHasProcedureStepCollection id:l3g2umNB
  }
  
  # We combine the two business item dates into one date for ordering purposes.
  BIND( COALESCE( ?businessItemDate, ?businessItemDate2 ) AS ?combinedDate )
} 

# We order the results by the combined business item date in descending order, so that the most recent work packages appear first.
ORDER BY DESC( ?combinedDate )

# We limit the number of results returned and we offset the results returned by a specified number.  
LIMIT #{limit} OFFSET #{offset}
    
    
    
    "
  ]     
  end
end