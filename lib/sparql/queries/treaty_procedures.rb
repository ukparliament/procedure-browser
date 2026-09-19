module Sparql::Queries::TreatyProcedures

  # A SPARQL query to get procedures for treaties.
  def treaty_procedures_query
    [
      # The title of the SPARQL query.
      "A list of treaty procedures",

      # The link to the SPARQL query.
      'https://api.parliament.uk/s/834d3f39',

      # The SPARQL query.
      "
# We declare the Parliament and ID namespaces.
PREFIX : <https://id.parliament.uk/schema/>
PREFIX id: <https://id.parliament.uk/>

# We select the properties we want to appear in results.
# If all properties are required, an asterisk can be used between SELECT and WHERE instead of listing properties.
# Distinct is used to ensure that work packages are not duplicated in the results.
SELECT DISTINCT ?procedure ?procedureName ?procedureDisplayOrder ?procedureDescription WHERE {

  	# We look for treaties that have a work package.
	?treaty a :Treaty;
	:workPackagedThingHasWorkPackage ?workPackage. 

    # We look for the work package's procedure.
    ?workPackage :workPackageHasProcedure ?procedure.

  	# We find the procedures name, display order and description.  
    ?procedure :name ?procedureName;
	:procedureDisplayOrder ?procedureDisplayOrder;
	:procedureDescription ?procedureDescription.

} 

# We order results by the number of the display order for the procedure and then procedure name. 
Order by ?procedureDisplayOrder ?procedureName
      "
    ]  
  end
end