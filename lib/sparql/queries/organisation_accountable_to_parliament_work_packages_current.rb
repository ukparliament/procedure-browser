module Sparql::Queries::OrganisationAccountableToParliamentWorkPackagesCurrent

  # A SPARQL query to get current work packages made available by an organisation accountable to Parliament.
  def organisation_accountable_to_parliament_work_packages_current_query( organisation_accountable_to_parliament_id, limit, offset )
    "
      PREFIX : <https://id.parliament.uk/schema/>
           PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
           PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
           PREFIX id: <https://id.parliament.uk/>
          SELECT distinct  ?LaidThing ?LaidThingName ?workPackage ?combinedDate ?procedure ?procedureName ?calculationStyle ?calculationStyleName WHERE {
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
     BIND(COALESCE(?businessItemDate, ?businessItemDate2) AS ?combinedDate)
     } Order by desc(?combinedDate)
     limit #{limit} offset #{offset}
    
    "
  end
end