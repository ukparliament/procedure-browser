module Sparql::Queries::HouseSteps

  # A SPARQL query to get steps in a house.
  def house_steps_query( house_id )
    "
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX id: <https://id.parliament.uk/>
      select * where { 
   
       ?House a :House ;
                     :name ?HouseName;
                      :houseHasProcedureStep ?Step. 
        filter (?House in (id:#{house_id}))
           ?Step :name ?StepName;
              :procedureStepHasProcedureStepType ?StepType.
        ?StepType :name ?StepTypeName.
         Optional {?Step:procedureStepHasHouse ?StepCommonsId
          filter (?StepCommonsId IN (id:1AFu55Hs))}
          Optional {?Step :procedureStepHasHouse ?StepLordsId.
            filter (?StepLordsId IN (id:WkUWUBMx))}
                 } order by ?StepName
    "
  end
end