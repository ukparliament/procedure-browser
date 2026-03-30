module Sparql::Queries::OrganisationAccountableToParliamentWorkPackagesCurrent

  # A SPARQL query to get current work packages made available by an organisation accountable to Parliament.
  def organisation_accountable_to_parliament_work_packages_current_query( organisation_accountable_to_parliament_id, limit, offset )
    "
    PREFIX : <https://id.parliament.uk/schema/>
              PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
              PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
              PREFIX id: <https://id.parliament.uk/>
              SELECT distinct  ?LaidThing ?LaidThingName ?workPackage ?combinedDate ?procedure ?procedureName ?calculationStyle ?calculationStyleName (BOUND(?stepId3) AS ?hasCommitteeConcernsFlag)   
     (BOUND(?stepId4) AS ?hasMotionTabledFlag) WHERE {
               { ?Organisations a :GovernmentOrganisation.}
               UNION {
              ?Organisations a :ArmsLengthBody.
                              }
                ?Organisations :name ?Name;
                               :layingBodyHasLaying ?Laying.
          ?Laying :layingHasLaidThing ?LaidThing.
                      filter (?Step in (id:cspzmb6w, id:isWn7s3K))
                ?LaidThing :name ?LaidThingName. 
                ?LaidThing :workPackagedThingHasWorkPackage ?workPackage.
                                   ?workPackage :workPackageHasProcedure ?procedure.
                        ?procedure :name ?procedureName.
                       optional { ?workPackage :workPackageHasCalculationStyle ?calculationStyle. 
                          ?calculationStyle :name ?calculationStyleName. }
                filter (?Organisations in (id:#{organisation_accountable_to_parliament_id}))
          optional {   ?workPackage :workPackageHasBusinessItem ?businessItem .
                   ?businessItem :businessItemHasProcedureStep ?step;
                          :businessItemDate ?businessItemDate.
            filter (?step in (id:isWn7s3K, id:cspzmb6w, id:ITNO9JWr, id:otscOTzB))}
            optional {    ?workPackage :workPackageHasBusinessItem ?businessItem2 .
                   ?businessItem2 :businessItemHasProcedureStep ?step2;
                                  :businessItemDate ?businessItemDate2.
            filter (?step2 in (id:AmYrFxwO))}
     MINUS {  ?workPackage   :workPackageHasBusinessItem ?bi2.
            ?bi2 :businessItemHasProcedureStep ?stepId2.
              ?stepId2 :procedureStepHasProcedureStepCollectionMembership/:procedureStepCollectionMembershipHasProcedureStepCollection id:TRohjSuI}
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
          BIND(COALESCE(?businessItemDate, ?businessItemDate2) AS ?combinedDate)
        } Order by desc(?combinedDate)

         Offset #{offset} limit #{limit}
    
    
    
    "
  end
end