module Sparql::Queries::WorkPackageableThing

  # A SPARQL query to get a work packageable thing.
  def work_packageable_thing_query( work_packageable_thing_id )
    "
# We declare the Parliament and ID namespaces.
PREFIX id: <https://id.parliament.uk/>
PREFIX : <https://id.parliament.uk/schema/>

# We select the properties we want to appear in results.
# If all properties are required, an asterisk can be used between SELECT and WHERE instead of listing properties.
SELECT ?workPackage ?workPackagedThing ?workPackagedThingName ?procedure ?procedureName ?webLink ?siPrefix ?siNumber ?siYear ?commandPaperPrefix ?commandPaperNumber ?leadGovernmentOrganisationId ?leadGovernmentOrganisationName ?treatySeriesCitation WHERE {


  ?workPackagedThing a :WorkPackagedThing;
	:name ?workPackagedThingName;
	:workPackagedThingHasWorkPackage ?workPackage.
	?workPackage :workPackageHasProcedure ?procedure.
	?procedure :name ?procedureName. 
	OPTIONAL {
    	?workPackagedThing :workPackagedThingHasWorkPackagedThingWebLink ?webLink.
  	}
	OPTIONAL {
    	?workPackagedThing :statutoryInstrumentPaperPrefix ?sIprefix.
  	}
	OPTIONAL {
    	?workPackagedThing :statutoryInstrumentPaperNumber ?sINumber.
  	}
	OPTIONAL {	
    	?workPackagedThing :statutoryInstrumentPaperYear ?sIYear.
  	}
	OPTIONAL {
    	?workPackagedThing :treatyCommandPaperNumber ?commandPaperNumber.
  	}
	OPTIONAL {	
    	?workPackagedThing :treatyCommandPaperPrefix ?commandPaperPrefix.
  	}
	OPTIONAL {	
    	?workPackagedThing :treatyHasLeadGovernmentOrganisation ?leadGovernmentOrganisationId.
		  ?leadGovernmentOrganisationId :name ?leadGovernmentOrganisationName.
  	}
	OPTIONAL {
    	?workPackagedThing :treatyHasSeriesMembership ?seriesMembershipId.  
		  ?seriesMembershipId :seriesItemCitation ?treatySeriesCitation.
  	}

	FILTER ( ?workPackagedThing IN ( id:#{work_packageable_thing_id} ) ) 
}
    "
  end
end