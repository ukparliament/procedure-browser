module Sparql::Queries::WorkPackagesCurrentAll

  # A SPARQL query to get current work package.
  def work_packages_current_all_query
    "
PREFIX :     <https://id.parliament.uk/schema/>
PREFIX id:   <https://id.parliament.uk/>

SELECT DISTINCT ?Paper ?Papername ?workPackage ?sINumber ?sIYear ?sIprefix ?commandPrefix ?commandPaperNumber ?seriesCitation ?businessItem ?step ?combinedDate ?procedure ?procedureName ?layingBody ?layingBodyName ?hasCommitteeConcernsFlag ?hasMotionTabledFlag  
WHERE {
  ?Paper a :WorkPackagedThing ;
  :name ?Papername ;
  :workPackagedThingHasWorkPackage ?workPackage .

  OPTIONAL {
    ?Paper :laidThingHasLaying ?laying .
    ?laying :businessItemHasProcedureStep id:cspzmb6w ;
    :layingHasLayingBody ?layingBody .
    ?layingBody :name ?layingBodyName .
	}       
  OPTIONAL {
    	?Paper :statutoryInstrumentPaperPrefix ?sIprefix;
            :statutoryInstrumentPaperYear ?sIYear.
  	}
	OPTIONAL {
    	?Paper :statutoryInstrumentPaperNumber ?sINumber.
  	}

	OPTIONAL {
    	?Paper :treatyCommandPaperNumber ?commandPaperNumber;
            :treatyCommandPaperPrefix ?commandPrefix.
  	}

	OPTIONAL {
    	?Paper :treatyHasSeriesMembership ?seriesMembershipId.  
		?seriesMembershipId :seriesItemCitation ?seriesCitation.
  	}

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
    ?businessItem2 :businessItemHasProcedureStep id:AmYrFxwO ;
                   :businessItemDate ?businessItemDate2 .
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

  FILTER NOT EXISTS {
    ?workPackage :workPackageHasBusinessItem ?bi2 .
    ?bi2 :businessItemHasProcedureStep ?stepId2 .
    ?stepId2 :procedureStepHasProcedureStepCollectionMembership/
    :procedureStepCollectionMembershipHasProcedureStepCollection id:TRohjSuI
  }

  BIND(COALESCE(?businessItemDate, ?businessItemDate2) AS ?combinedDate)
}
ORDER BY DESC(?combinedDate) ?Papername
    "
  end
end
