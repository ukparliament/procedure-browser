module Sparql::Queries::Legislature

  # A SPARQL query to get a legislature.
  def legislature_query( legislature_id )
    [

      # The title of the SPARQL query.
      'A legislature',
  
      # The link to the SPARQL query.
      '',
  
      # The SPARQL query.
      "
        # We declare the Parliament and ID namespaces.
        PREFIX : <https://id.parliament.uk/schema/>
        PREFIX id: <https://id.parliament.uk/>
        
        # We select all properties returned.
        SELECT *
        
        # We find all the legislatures and get their name.
        WHERE {
          ?legislature a :Legislature ;
          :name ?legislatureName.
          
          # We filter the results to only include the legislature with ID #{legislature_id}.
          FILTER ( ?legislature in ( id:#{legislature_id} ) )
        } 
      "
    ]
  end
end