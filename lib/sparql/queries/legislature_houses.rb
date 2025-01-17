module Sparql::Queries::LegislatureHouses

  # A SPARQL query to get Houses in a legislature.
  def legislature_houses_query( legislature_id )
    "
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX id: <https://id.parliament.uk/>
      select * where { 
  
  
       ?Legislature a :Legislature ;
                    :name ?LegislatureName;
                    :legislatureHasHouse ?House. 
        ?House :name ?HouseName. 
        filter (?Legislature in (id:#{legislature_id}))
  
                 } order by ?HouseName
    "
  end
end