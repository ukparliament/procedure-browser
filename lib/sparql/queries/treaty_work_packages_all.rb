module Sparql::Queries::TreatyWorkPackagesAll

  # A SPARQL query to get all treaty work packages.
  def treaty_work_packages_all_query
    "
      
PREFIX : <https://id.parliament.uk/schema/>
PREFIX id: <https://id.parliament.uk/>
SELECT DISTINCT ?Paper ?Papername ?workPackage ?businessItem ?combinedDate ?procedure ?procedure ?procedureName ?layingBody ?layingBodyName (BOUND(?stepId3) AS ?hasCommitteeConcernsFlag)   
(BOUND(?stepId4) AS ?hasMotionTabledFlag)  WHERE {

  ?Paper a :Treaty;
  :name ?Papername ;
  :workPackagedThingHasWorkPackage ?workPackage.

  OPTIONAL {
    ?Paper :laidThingHasLaying ?laying .
    ?laying :businessItemHasProcedureStep id:cspzmb6w ;
    :layingHasLayingBody ?layingBody .
    ?layingBody :name ?layingBodyName .
	}

  OPTIONAL {   
    ?workPackage :workPackageHasBusinessItem ?businessItem .
    ?businessItem :businessItemHasProcedureStep ?step;
    :businessItemDate ?businessItemDate.
    FILTER ( ?step IN ( id:isWn7s3K, id:cspzmb6w, id:ITNO9JWr, id:otscOTzB ) ) 
  }
  OPTIONAL { 
    ?workPackage :workPackageHasBusinessItem ?businessItem2 .
    ?businessItem2 :businessItemHasProcedureStep ?step2;
    :businessItemDate ?businessItemDate2.
    FILTER ( ?step2 IN ( id:AmYrFxwO ) )
  }
  ?workPackage :workPackageHasProcedure ?procedure.
  ?procedure :name ?procedureName.
                   
  OPTIONAL {
    ?workPackage :workPackageHasBusinessItem ?bi3 .
    ?bi3 :businessItemHasProcedureStep ?stepId3 .
    ?stepId3 :procedureStepHasProcedureStepCollectionMembership/
    :procedureStepCollectionMembershipHasProcedureStepCollection id:7CBVQcZF
  }

  OPTIONAL {
    ?workPackage :workPackageHasBusinessItem ?bi4 .
    ?bi4 :businessItemHasProcedureStep ?stepId4 .
    ?stepId4 :procedureStepHasProcedureStepCollectionMembership/
    :procedureStepCollectionMembershipHasProcedureStepCollection id:l3g2umNB
  }
  BIND( COALESCE( ?businessItemDate, ?businessItemDate2 ) AS ?combinedDate )
} 
ORDER BY DESC(?combinedDate) ?Papername
    "
  end
end
