module Sparql::Queries::OrganisationAccountableToParliamentWorkPackages

  # A SPARQL query to get all work packages made available by an organisation accountable to Parliament.
  def organisation_accountable_to_parliament_work_packages_query( organisation_accountable_to_parliament_id, limit, offset )
    "
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX id: <https://id.parliament.uk/>
      SELECT distinct  ?LaidThing ?LaidThingName ?workPackage ?LaidDate ?procedure ?procedureName ?calculationStyle ?calculationStyleName WHERE {
       { ?Organisations a :GovernmentOrganisation.}
       UNION {
      ?Organisations a :ArmsLengthBody.
                      }
        ?Organisations :name ?Name;
                       :layingBodyHasLaying ?Laying.
        ?Laying :layingHasLaidThing ?LaidThing;
                :businessItemHasProcedureStep ?Step;
                :layingDate ?LaidDate.
        filter (?Step in (id:cspzmb6w, id:isWn7s3K))
        ?LaidThing :name ?LaidThingName. 
        ?LaidThing :workPackagedThingHasWorkPackage ?workPackage.
                           ?workPackage :workPackageHasProcedure ?procedure.
                ?procedure :name ?procedureName.
               optional { ?workPackage :workPackageHasCalculationStyle ?calculationStyle. 
                  ?calculationStyle :name ?calculationStyleName. }
        filter (?Organisations in (id:#{organisation_accountable_to_parliament_id}))
  
  
      } Order by desc(?LaidDate)

      Offset #{offset} Limit #{limit}
    "
  end
end