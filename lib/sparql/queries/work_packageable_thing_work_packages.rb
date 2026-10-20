module Sparql::Queries::WorkPackageableThingWorkPackages

  # A SPARQL query to get a list of all work packages for a work packageable thing.
  def work_packageable_thing_work_packages_query( work_packageable_thing_id )
    "
PREFIX id: <https://id.parliament.uk/>
PREFIX : <https://id.parliament.uk/schema/>
        
SELECT ?workPackage ?workPackagedThing ?workPackagedThingName ?combinedDate ?procedure ?procedureName ?calculationStyle ?calculationStyleName ?layingBody ?layingBodyName WHERE {

  	?workPackagedThing a :WorkPackagedThing;
	:name ?workPackagedThingName;
	:workPackagedThingHasWorkPackage ?workPackage.

	VALUES ?workPackagedThing { id:#{work_packageable_thing_id} }

  	OPTIONAL {
    	?workPackagedThing :laidThingHasLaying ?laying .
    	?laying :businessItemHasProcedureStep id:cspzmb6w ;
        :layingHasLayingBody ?layingBody .
    	?layingBody :name ?layingBodyName .
	}

	?workPackage :workPackageHasProcedure ?procedure.
	?procedure :name ?procedureName. 

	OPTIONAL {	
    	?workPackage :workPackageHasBusinessItem ?businessItem .
		?businessItem :businessItemHasProcedureStep ?step;
		:businessItemDate ?businessItemDate.
		VALUES ?step {
    		id:isWn7s3K
   			id:cspzmb6w
    		id:ITNO9JWr
    		id:otscOTzB
		}
  	}

	OPTIONAL {    
    	?workPackage :workPackageHasBusinessItem ?businessItem2 .
		?businessItem2 :businessItemHasProcedureStep id:AmYrFxw0;
		:businessItemDate ?businessItemDate2.

      	}



	BIND( COALESCE ( ?businessItemDate, ?businessItemDate2) AS ?combinedDate )

	OPTIONAL {
    	?workPackage :workPackageHasCalculationStyle ?calculationStyle. 
		?calculationStyle :name ?calculationStyleName. 
  	}
} 

ORDER BY DESC(?combinedDate) ?workPackagedThingName
    "
  end
end



