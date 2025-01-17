module Sparql::Queries::Houses

  # A SPARQL query to get all Houses.
  def houses_query
    "
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX id: <https://id.parliament.uk/>
      select * where { 
   
       ?House a :House ;
                     :name ?HouseName. 
                 } order by ?HouseName
    "
  end
end