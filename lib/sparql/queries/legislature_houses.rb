module Sparql::Queries::LegislatureHouses

  # A SPARQL query to get Houses in a legislature.
  def legislature_houses_query( legislature_id )
    [
  
      # The title of the SPARQL query.
      "A list of a legislature's Houses",
    
      # The link to the SPARQL query.
      'https://api.parliament.uk/s/89f7f66b',
    
      # The SPARQL query.
      "
	      # We declare the Parliament and ID namespaces.
	      PREFIX : <https://id.parliament.uk/schema/>
	      PREFIX id: <https://id.parliament.uk/>

	      # We select all properties returned.
	      SELECT * WHERE { 
  
	      # We find all the legislatures and get their name.
        ?legislature a :Legislature ;
        :name ?legislatureName;

	      # We look only for legislatures that have one or more Houses. 
	      :legislatureHasHouse ?house. 

	      # We look for a House's name.   
	      ?house :name ?houseName. 

	      # We filter the results to only include the legislature with ID #{legislature_id}.
          FILTER ( ?legislature in ( id:#{legislature_id} ) )  
	      } 

	      # We order results by House name. 
	      ORDER BY ?houseName
     "
    ]
  end
end
