module Sparql::Queries::ProcedureStepTypeSteps

  # A SPARQL query to get steps of a step type in a procedure.
  def procedure_step_type_steps_query( procedure_id, step_type_id )
    [
  
      # The title of the SPARQL query.
      'A list of steps of a type within a procedure',
    
      # The link to the SPARQL query.
      'https://api.parliament.uk/s/8e1e5729',
      
      # The SPARQL query.
      "
# We declare the Parliament and ID namespaces.
PREFIX : <https://id.parliament.uk/schema/>
PREFIX id: <https://id.parliament.uk/>

# We select the properties we want to appear in results. If all properties are required, an asterisk can be used between SELECT and WHERE instead of listing properties.
SELECT DISTINCT ?procedure ?procedureName ?stepType ?stepTypeLabel ?step ?stepName ?legislature ?legislatureName ?commonsId ?lordsId (COALESCE(?rawBiCount, 0) AS ?biCount) WHERE {

# We set the value of the procedure property.   
VALUES ?procedure { id:D00dsjR2 }  

# We specify that the procedure property is a procedure and look for its name.   
?procedure a :Procedure;
:name ?procedureName.

# We look for all procedure routes and the steps in those routes, including whether they are a From step or a To step. The pipe in line 17 is a SPARQL OR.  
?procedure :procedureHasProcedureRoute ?route.
?route :procedureRouteIsFromProcedureStep|:procedureRouteIsToProcedureStep ?step.

# We specify the procedure step must have a name, a step type and that the step type also has a name.   
?step :name ?stepName.
?step :procedureStepHasProcedureStepType ?stepType.
?stepType :name ?stepTypeLabel.

# We limit steps to being only of the type 'Business step'.
FILTER (?stepType in (id:Jwc6nqJi)) 

# We check to see if the step belongs to a legislature. A legislature will be Scottish Parliament, Senedd Cymru or the Northern Ireland Assembly.   
OPTIONAL {?step :procedureStepInLegislature ?legislature .
?legislature :name ?legislatureName .}

# We check to see if the step belongs to the House of Commons.     
OPTIONAL {?step :procedureStepHasHouse ?commonsId .
FILTER (?commonsId = id:1AFu55Hs)}

# We check to see if the step belongs to the House of Lords.   
OPTIONAL {?step :procedureStepHasHouse ?lordsId .
FILTER (?lordsId = id:WkUWUBMx)}

# We specify an optional subquery which calculates the number of distinct business items that actualise a steps from the procedure. We make it optional because not every step will be actualised in a business item.   
OPTIONAL {
SELECT ?step (COUNT(DISTINCT ?bi) AS ?rawBiCount)
WHERE {
# We find business items actualising the step. 
?step :procedureStepHasBusinessItem ?bi .

# We find the work package each business item belongs to.
?bi :businessItemHasWorkPackage ?wp.

# We specify that the work packages must have the procedure. 
?wp :workPackageHasProcedure id:D00dsjR2.}

# We group the results by step.    
GROUP BY ?step}
}

# We order the results by step name. 
ORDER BY ?stepName
      "
    ]
  end
end