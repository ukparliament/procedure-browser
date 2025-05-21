module Sparql::Queries::OrganisationAccountableToParliamentWorkPackageCount

  # A SPARQL query to get a count of all work packages for an organisation accountable to Parliament.
  def organisation_accountable_to_parliament_work_package_count_query( organisation_accountable_to_parliament_id )
    "
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX id: <https://id.parliament.uk/>
      SELECT distinct  (count(distinct ?LaidThing) as ?count) WHERE {
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
      }
    "
  end
end
