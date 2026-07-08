module Sparql::Queries::LegislatureSteps

# A SPARQL query to get steps in a legislature.
  def legislature_steps_query( legislature_id )
    [
  
      # The title of the SPARQL query.
      "A list of a legislature's steps with a count of their actualisations",
    
      # The link to the SPARQL query.
      'https://api.parliament.uk/s/876778a9',
    
      # The SPARQL query.
      "
      	# We declare the Parliament and ID namespaces.
	      PREFIX : <https://id.parliament.uk/schema/>
	      PREFIX id: <https://id.parliament.uk/>

	      # We select the properties we want to appear in results. If all properties are required, an asterisk can 	be used between SELECT and WHERE instead of listing properties.
	      SELECT ?legislature ?legislatureName ?step ?stepName ?stepType ?stepTypeName (COUNT(?businessItem) AS ?businessItemCount)   WHERE { 

	      # We find all the legislatures and their name. We also specify to only show legislatures with procedure	steps.   
	      ?legislature a :Legislature ;
	      :name ?legislatureName;
	      :legislatureHasProcedureStep ?step. 

	      # We filter the results to only include the legislature with ID #{legislature_id}.
        	FILTER ( ?legislature in ( id:#{legislature_id} ) )  

	      # We specify the procedure step must have a name, a step type and that the step type also has a name. 
	      ?step :name ?stepName;
	      :procedureStepHasProcedureStepType ?stepType.
	      ?stepType :name ?stepTypeName.
  
	      # We specify that the legislature's procedure steps may, or may not, have been actualised in a business	item. This is then used in the SELECT line to work out a count of the number of business items that the	procedure step has been actualised in.    
	      OPTIONAL { ?step :procedureStepHasBusinessItem ?businessItem }  
	      } 

	      # We use GROUP BY because COUNT(?businessItem) in line 6 is an aggregate, and we want the count calculated separately for each procedure step (and its associated legislature and step type details).
	      GROUP BY ?legislature ?legislatureName ?step ?stepName ?stepType ?stepTypeName

	      # We order by the name of the procedure step. 
	      ORDER BY ?stepName
     "
    ]
  end
end
