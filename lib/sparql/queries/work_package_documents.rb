module Sparql::Queries::WorkPackageDocuments

  # A SPARQL query to get all business items in a work package with a link, actualising steps in the reading list collection.
  def work_package_documents_query( work_package_id )
    [
  
      # The title of the SPARQL query.
      'A list of business items in a work package with a link, actualising steps in the reading list collection',
    
      # The link to the SPARQL query.
      'https://api.parliament.uk/s/522d9a8a',
    
      # The SPARQL query.
      "
        # We declare the Parliament and ID namespaces.
        PREFIX : <https://id.parliament.uk/schema/>
        PREFIX id: <https://id.parliament.uk/>

        # We select the relevant properties we want to appear in  results. 
        SELECT ?paper ?paperName ?workPackage ?businessItem ?businessItemLink ?businessItemProcedureStep ?businessItemDate ?businessItemProcedureStepName?legislature ?legislatureName ?commonsId ?lordsId WHERE {
        # We find all papers with a name and a work package.
        ?paper a :WorkPackagedThing ;  
        :name ?paperName ;
        :workPackagedThingHasWorkPackage ?workPackage.

        # We specify a specific work package using its ID. 
        FILTER (?workPackage IN (id:#{work_package_id}))

        # We find business items associated with the work package.    
        ?workPackage :workPackageHasBusinessItem ?businessItem.
  
        # We specify that business items must have a web link and that we're also looking for a business item's procedure step. 
        ?businessItem :businessItemHasBusinessItemWebLink ?businessItemLink;
        :businessItemHasProcedureStep ?businessItemProcedureStep. 

        # We specify that business items might have a date but it is not required. 
        OPTIONAL {?businessItem :businessItemDate ?businessItemDate}

        # We look for business items that are part of the 'Reading list' step collection. This means only work packages that have a business item actualising a step from that step collection will appear in the results.
        ?businessItemProcedureStep :procedureStepHasProcedureStepCollectionMembership/:procedureStepCollectionMembershipHasProcedureStepCollection  id:Ji8bWVUj. 

        # We look for the names of procedure steps that are actualised by a business item. 
        ?businessItemProcedureStep :name ?businessItemProcedureStepName.
  
        # We specify whether a procedure step belongs to a legislature and specify the results should show the legislature's name. 
        OPTIONAL {?businessItemProcedureStep :procedureStepInLegislature ?legislature.
        ?legislature :name ?legislatureName.}

        # We specify whether a procedure step belongs to the House of Commons. 
        OPTIONAL {?businessItemProcedureStep :procedureStepHasHouse ?commonsId.
        # We specify the House ID for the House of Commons.
        FILTER (?commonsId IN (id:1AFu55Hs))}
  
        # We specify whether a procedure step belongs to the House of Lords.   
        OPTIONAL {?businessItemProcedureStep :procedureStepHasHouse ?lordsId.
        # We specify the House ID for the House of Lords.    
        FILTER (?lordsId IN (id:WkUWUBMx))} } 

        # We order the results by business item date.  
        ORDER BY ?businessItemDate
      "
    ]
  end
end