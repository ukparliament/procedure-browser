module Sparql::Queries::SecondaryLegislationWorkPackagesAll

  # A SPARQL query to get all secondary legislation work packages.
  def secondary_legislation_work_packages_all_query
    "
PREFIX : <https://id.parliament.uk/schema/>
PREFIX id: <https://id.parliament.uk/>

SELECT DISTINCT
    ?Paper
    ?Papername
    ?workPackage
    ?businessItem
    ?businessItemDate
    ?procedure
    ?procedureName
    ?calculationStyle
    ?calculationStyleName
    ?hasCommitteeConcernsFlag
    ?hasMotionTabledFlag
WHERE {

    ?Paper a :EnabledThing ;
           :name ?Papername ;
           :workPackagedThingHasWorkPackage ?workPackage .

    OPTIONAL {
        ?workPackage :workPackageHasBusinessItem ?businessItem .
        ?businessItem :businessItemHasProcedureStep ?step ;
                      :businessItemDate ?businessItemDate .

        VALUES ?step {
            id:isWn7s3K
            id:cspzmb6w
                    }
    }

       ?workPackage :workPackageHasProcedure ?procedure .

    ?procedure :name ?procedureName .

    OPTIONAL {
        ?workPackage :workPackageHasCalculationStyle ?calculationStyle .
        ?calculationStyle :name ?calculationStyleName .
    }


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
ORDER BY DESC(?businessItemDate) ?Papername
    "
  end
end
