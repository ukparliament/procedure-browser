module Sparql::Queries::WorkPackagesAll

  # A SPARQL query to get all work packages.
  def work_packages_all_query
    "
PREFIX : <https://id.parliament.uk/schema/>
PREFIX id: <https://id.parliament.uk/>

SELECT DISTINCT
    ?Paper
    ?Papername
    ?workPackage
    ?businessItem
    ?combinedDate
    ?procedure
    ?procedureName
    ?calculationStyle
    ?calculationStyleName
    ?hasCommitteeConcernsFlag
    ?hasMotionTabledFlag
WHERE {

    ?Paper a :WorkPackagedThing ;
           :name ?Papername ;
           :workPackagedThingHasWorkPackage ?workPackage .

    OPTIONAL {
        ?workPackage :workPackageHasBusinessItem ?businessItem .
        ?businessItem :businessItemHasProcedureStep ?step ;
                      :businessItemDate ?businessItemDate .

        VALUES ?step {
            id:isWn7s3K
            id:cspzmb6w
            id:ITNO9JWr
            id:otscOTzB
        }
    }

    OPTIONAL {
        ?workPackage :workPackageHasBusinessItem ?businessItem2 .
        ?businessItem2 :businessItemHasProcedureStep ?step2 ;
                       :businessItemDate ?businessItemDate2 .

        VALUES ?step2 {
            id:AmYrFxwO
        }
    }

    ?workPackage :workPackageHasProcedure ?procedure .

    ?procedure :name ?procedureName .

    OPTIONAL {
        ?workPackage :workPackageHasCalculationStyle ?calculationStyle .
        ?calculationStyle :name ?calculationStyleName .
    }

    BIND(
        COALESCE(?businessItemDate, ?businessItemDate2)
        AS ?combinedDate
    )

    BIND(
        EXISTS {
            ?workPackage :workPackageHasBusinessItem ?bi3 .
            ?bi3 :businessItemHasProcedureStep ?stepId3 .

            ?stepId3
                :procedureStepHasProcedureStepCollectionMembership/
                :procedureStepCollectionMembershipHasProcedureStepCollection
                id:7CBVQcZF .
        }
        AS ?hasCommitteeConcernsFlag
    )

    BIND(
        EXISTS {
            ?workPackage :workPackageHasBusinessItem ?bi4 .
            ?bi4 :businessItemHasProcedureStep ?stepId4 .

            ?stepId4
                :procedureStepHasProcedureStepCollectionMembership/
                :procedureStepCollectionMembershipHasProcedureStepCollection
                id:l3g2umNB .
        }
        AS ?hasMotionTabledFlag
    )
}
ORDER BY DESC(?combinedDate) ?Papername
    "
  end
end
