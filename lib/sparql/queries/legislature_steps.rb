module Sparql::Queries::LegislatureSteps

  # A SPARQL query to get steps in a legislature.
  def legislature_steps_query( legislature_id )
    "
      PREFIX : <https://id.parliament.uk/schema/>
          PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
          PREFIX id: <https://id.parliament.uk/>
          select ?Legislature ?LegislatureName ?Step ?StepName ?StepType ?StepTypeName (COUNT(?bi) AS ?biCount)   where { 
  
  
           ?Legislature a :Legislature ;
                        :name ?LegislatureName;
                        :legislatureHasProcedureStep ?Step. 
      OPTIONAL { ?Step :procedureStepHasBusinessItem ?bi }
            ?Step :name ?StepName;
                  :procedureStepHasProcedureStepType ?StepType.
            ?StepType :name ?StepTypeName.
              filter (?Legislature in (id:#{legislature_id}))
                       } 
      GROUP BY ?Legislature ?LegislatureName ?Step ?StepName ?StepType ?StepTypeName
      Order by ?StepName
    "
  end
end