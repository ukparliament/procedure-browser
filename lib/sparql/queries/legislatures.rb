module Sparql::Queries::Legislatures

  # A SPARQL query to get all legislatures.
  def legislatures_query
    "
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX id: <https://id.parliament.uk/>
      select * where { 
  
  
       ?Legislature a :Legislature ;
                    :name ?LegislatureName. 
     
            } Order by ?LegislatureName
    "
  end
end