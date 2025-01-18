module Sparql::Queries::HouseStepCollections

  # A SPARQL query to get step collections for a house.
  def house_step_collections_query( house_id )
    "
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX id: <https://id.parliament.uk/>
      select * where { 
   
       ?House a :House ;
                     :name ?HouseName;
                      :houseHasProcedureStepCollection ?StepCollection. 
        	?StepCollection :name ?StepCollectionName.               
        filter (?House in (id:#{house_id}))
                 } 
    "
  end
end