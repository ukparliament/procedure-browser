module Sparql::Queries::Legislatures

  # A SPARQL query to get all legislatures.
  def legislatures_query
    [ 
  
      # The title of the SPARQL query.
      'A full list of legislatures',
    
      # The link to the SPARQL query.
      'https://api.parliament.uk/s/fdba8abc',
    
      # The SPARQL query.
      "
        PREFIX : <https://id.parliament.uk/schema/>
        PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
        PREFIX id: <https://id.parliament.uk/>
        SELECT *
        # An example of a SPARQL comment.
        WHERE {
          ?Legislature a :Legislature ;
          :name ?LegislatureName.
        }
        ORDER BY ?LegislatureName
      "
    ]
  end
end