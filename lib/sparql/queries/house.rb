module Sparql::Queries::House

  # A SPARQL query to get a House.
  def house_query( house_id )
    "
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX id: <https://id.parliament.uk/>
      select * where { 
   
       ?House a :House ;
                     :name ?HouseName;
                     :houseInLegislature ?Legislature.
        ?Legislature :name ?LegislatureName. 
        filter (?House in (id:#{house_id}))
  
                 } 
    "
  end
end