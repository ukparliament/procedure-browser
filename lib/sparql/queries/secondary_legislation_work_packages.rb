module Sparql::Queries::SecondaryLegislationWorkPackages

  # A SPARQL query to get all secondary legislation work packages taking parameters of limit and offset.
  def secondary_legislation_work_packages_query( limit, offset )
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
    ?layingBody
    ?layingBodyName
    ?hasCommitteeConcernsFlag
    ?hasMotionTabledFlag
WHERE {

    ?Paper a :EnabledThing ;
    :name ?Papername ;
    :workPackagedThingHasWorkPackage ?workPackage .

    OPTIONAL {
        ?Paper :laidThingHasLaying ?laying .
        ?laying :businessItemHasProcedureStep id:cspzmb6w ;
        :layingHasLayingBody ?layingBody .
        ?layingBody :name ?layingBodyName .
	}      

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
Limit #{limit} offset #{offset}
    "
  end
end
