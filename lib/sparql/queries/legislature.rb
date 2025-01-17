module Sparql::Queries::Legislature

  # A SPARQL query to get a legislature.
  def legislature_query( legislature_id )
    "
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX id: <https://id.parliament.uk/>
      select * where { 
  
  
       ?Legislature a :Legislature ;
                    :name ?LegislatureName. 
        filter (?Legislature in (id:#{legislature_id}))
                 } 
    "
  end
end