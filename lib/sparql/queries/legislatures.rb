module Sparql::Queries::Legislatures

  # A SPARQL query to get all legislatures.
  def legislatures_query
    [
  
      # The title of the SPARQL query.
      'A list of legislatures',
    
      # The link to the SPARQL query.
      'https://api.parliament.uk/s/454fe00f',
    
      # The SPARQL query.
      "
        # We declare the Parliament namespace.
        PREFIX : <https://id.parliament.uk/schema/>
        
        # We select all properties returned.
        SELECT *
        
        # We find all the legislatures and get their name.
        WHERE {
          ?legislature a :Legislature ;
          :name ?legislatureName.
        }
        
        # We order by the name of the legislature.
        ORDER BY ?legislatureName
      "
    ]
  end
end