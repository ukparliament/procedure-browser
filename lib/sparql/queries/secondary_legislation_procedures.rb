module Sparql::Queries::SecondaryLegislationProcedures

  # A SPARQL query to get procedures for secondary legislation.
  def secondary_legislation_procedures_query
    [
      # The title of the SPARQL query.
      "A list of secondary legislation procedures",

      # The link to the SPARQL query.
      'https://api.parliament.uk/s/0d179f8a',

      # The SPARQL query.
      "
# We declare the Parliament and ID namespaces.
PREFIX : <https://id.parliament.uk/schema/>
PREFIX id: <https://id.parliament.uk/>

# We select the properties we want to appear in results.
# If all properties are required, an asterisk can be used between SELECT and WHERE instead of listing properties.
SELECT * WHERE {

	# We find all procedures with their name, display order and description.   
	?procedure a :Procedure;
	:name ?procedureName;
	:procedureDisplayOrder ?procedureDisplayOrder;
	:procedureDescription ?procedureDescription.

  	# We filter the results to only show procedures for secondary legislation. These are the IDs for those procedures. 
  	FILTER (?procedure IN (id:H5YJQsK2, id:iWugpxMn, id:gTgidljI, id:5S6p4YsP, id:iCdMN1MW, id:kgFvgMIf, id:OvnVdtXG, id:1HAWKzS2, id:iAISgq1R, id:dWV8Yjj6, id:jaKY87jt ) )   
} 

# We order results by the number of the display order for the procedure and then procedure name. 
Order by ?procedureDisplayOrder ?procedureName
      "
    ]  
  end
end