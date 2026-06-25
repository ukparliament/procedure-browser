module Sparql::Queries::EnablingLegislationsCurrent

  # A SPARQL query to get all legislation enabling an instrument currently before Parliament.
  def enabling_legislations_current_query
    [
    
      # The title of the SPARQL query.
      'A list of legislation enabling instruments currently before Parliament',
      
      # The link to the SPARQL query.
      '',
      
      # The SPARQL query.
      "
        # We declare the Parliament and ID namespaces.
        PREFIX : <https://id.parliament.uk/schema/>
        PREFIX id: <https://id.parliament.uk/>

        # We select the relevant properties we want to appear in results.
        SELECT DISTINCT ?enablingThing ?name ?number ?year ?date ?URL WHERE {
  
        # We find all enabling things that enable one or more things currently before Parliament.
        ?enablingThing a :EnablingThing;  
        :enabling ?enabledThing.

        # We look for the names of those enabling things.
        ?enablingThing :actOfParliamentName ?name.

        # We specify that an enabling thing might have a name, number, year, date and url but is not required to have any of those properties. 
        OPTIONAL { ?enablingThing :actOfParliamentNumber ?number. }
        OPTIONAL { ?enablingThing :actOfParliamentYear ?year. }
        OPTIONAL { ?enablingThing :actOfParliamentRoyalAssentDate ?date. }
        OPTIONAL { ?enablingThing :actOfParliamentUrl ?url. }

        # We look for enabled things that have a work package.  
        ?enabledThing :workPackagedThingHasWorkPackage ?workPackage.

        # We specify that the work package should not have a business item that actualises a step in the 'End steps' step collection. This means only work packages that have not been concluded will appear in the results. 
        MINUS { ?workPackage :workPackageHasBusinessItem ?bi2.
        ?bi2 :businessItemHasProcedureStep ?stepId2.
        # We specify the id for the 'End steps' step collection.    
        ?stepId2 :procedureStepHasProcedureStepCollectionMembership/:procedureStepCollectionMembershipHasProcedureStepCollection id:TRohjSuI} 
        }

        # We order the results by name.  
        ORDER BY ?name
      "
    ]
  end
end
