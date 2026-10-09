module Sparql::Queries::HouseSteps

  # A SPARQL query to get steps in a house.
  def house_steps_query( house_id )
[
          # The title of the SPARQL query.
      'A list of steps for a House',
      
      # The link to the SPARQL query.
      'https://api.parliament.uk/s/f9ce4d70',
      
      # The SPARQL query.

    "
# We declare the Parliament and ID namespaces.
PREFIX : <https://id.parliament.uk/schema/>
PREFIX id: <https://id.parliament.uk/>

# We select the relevant properties we want to appear in results.
# If all properties are required, an asterisk can be used between SELECT and WHERE instead of listing properties.
SELECT ?house ?houseName ?step ?stepName ?stepType ?stepTypeName ?stepCommonsId ?stepLordsId (COUNT(?bi) AS ?biCount)   where { 
   
  # We find all houses that have a procedure step and get the name of the house.
  ?house a :House ;
  :name ?houseName;
  :houseHasProcedureStep ?step. 

  # We look for steps that may or may not have been actualised in a business item. We count the number of business items for each step in the SELECT line.
  OPTIONAL { 
    ?step :procedureStepHasBusinessItem ?bi 
  }
  
  # We filter the results to only include steps for the specified house.
  FILTER ( ?house IN ( id:#{house_id} ) )

  # We find the name of the step and the type of the step.
  ?step :name ?stepName;
  :procedureStepHasProcedureStepType ?stepType.
  ?stepType :name ?stepTypeName.

  # # We check to see if the step belongs to the House of Commons.
  OPTIONAL {
    ?step :procedureStepHasHouse ?stepCommonsId
    FILTER ( ?stepCommonsId IN ( id:1AFu55Hs ) )
  }
  # We check to see if the step belongs to the House of Lords
  OPTIONAL { 
    ?step :procedureStepHasHouse ?stepLordsId.
    FILTER ( ?stepLordsId IN ( id:WkUWUBMx ) )
  }
} 

# We group the results by the selected properties.
GROUP BY ?house ?houseName ?step ?stepName ?stepType ?stepTypeName ?stepCommonsId ?stepLordsId

# We order the results by the name of the step.
ORDER BY ?stepName

    
    "
  ]
  end
end