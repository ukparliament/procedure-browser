module Sparql::Queries::RouteProcedures

  # A SPARQL query to get procedures for a route.
  def route_procedures_query( route_id )
    "
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
           PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
           PREFIX : <https://id.parliament.uk/schema/>
           PREFIX id: <https://id.parliament.uk/>
           select ?procedure ?procedureName where {
            ?Route a :ProcedureRoute;
                   :procedureRouteHasProcedure ?procedure.
       ?procedure :name ?procedureName. 
          filter (?Route IN (id:#{route_id}))   
           } order by ?procedureName
    "
  end
end
