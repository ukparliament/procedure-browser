module Sparql::Queries::WorkPackage

   # A SPARQL query to get a work package.
  def work_package_query( work_package_id )
    [
  
      # The title of the SPARQL query.
      'A work package',
    
      # The link to the SPARQL query.
      'https://api.parliament.uk/s/dac058f9',
    
      # The SPARQL query.
      "
        # We declare the Parliament and ID namespaces.
        PREFIX : <https://id.parliament.uk/schema/>
        PREFIX id: <https://id.parliament.uk/>

        # We select the properties we want to appear in results. The asterisk will select all properties from the query.
        SELECT * WHERE {
        # We find all papers with a name and a work package.
        ?paper a :WorkPackagedThing .  
        ?paper :name ?paperName ;
        :workPackagedThingHasWorkPackage ?workPackage.

        # We specify that a paper might have a web link. 
        OPTIONAL {?paper :workPackagedThingHasWorkPackagedThingWebLink ?workPackagedThingWebLink.}
  
        # We specify that a paper might have a laying with a laid date. We also specify that a laying will have a procedure step.  
        OPTIONAL {?paper :laidThingHasLaying ?laying.
        ?laying :layingDate ?laidDate;
        :businessItemHasProcedureStep ?step.
    
        # We specify that the laying will have one of two steps - 'Laid before the House of Commons' or 'Notification from Department announcing the publication of the draft laid before the House of Commons'. 
        FILTER (?step in (id:isWn7s3K, id:cspzmb6w))}

        # We look for work packages with a procedure and the procedure's name.   
        ?workPackage :workPackageHasProcedure ?procedure.
        ?procedure :name ?procedureName.

        # We specify that a work package may have a calculcation style with it's name but that a calculation style is not required. 
        OPTIONAL{ ?workPackage :workPackageHasCalculationStyle ?calculationStyle. 
        ?calculationStyle :name ?calculationStyleName. }

        # We specify a specific work package using its ID. 
        FILTER (?workPackage in (id:#{work_package_id}))
        } 
      "
    ]
  end
end
