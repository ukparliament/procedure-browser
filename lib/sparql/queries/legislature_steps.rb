module Sparql::Queries::LegislatureSteps

  # A SPARQL query to get steps in a legislature.
  def legislature_steps_query( legislature_id )
    "
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX id: <https://id.parliament.uk/>
      select * where { 
  
  
       ?Legislature a :Legislature ;
                    :name ?LegislatureName;
                    :legislatureHasProcedureStep ?Step. 
        ?Step :name ?StepName;
              :procedureStepHasProcedureStepType ?StepType.
        ?StepType :name ?StepTypeName.
          filter (?Legislature in (id:#{legislature_id}))
                   } Order by ?StepName 
    "
  end
end