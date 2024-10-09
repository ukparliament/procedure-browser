module STEP_WORK_PACKAGEABLE_THINGS_QUERY

  Sparql::Queries::StepWorkPackageableThings = true

  # A SPARQL query to get work packagaeable things for a step.
  def step_work_packageable_things_query( step_id )
    "
      PREFIX id: <https://id.parliament.uk/>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      SELECT ?Step ?stepName ?stepType ?stepTypeLabel ?legislature ?legislatureName ?CommonsId ?LordsId ?workPackage ?procedure ?procedureName ?workPackagedThing ?workpackagedThingName WHERE {

        ?Step a :ProcedureStep;
                  :name ?stepName;
                  :procedureStepHasBusinessItem ?businessItem;
                  :procedureStepHasProcedureStepType ?stepType.
          filter (?Step IN (id:#{step_id}))
             ?stepType :name ?stepTypeLabel.
        optional {?Step :procedureStepInLegislature ?legislature.
                ?legislature :name ?legislatureName.}
        optional {?Step:procedureStepHasHouse ?CommonsId.
                    filter (?CommonsId IN (id:1AFu55Hs))}
        optional {?Step :procedureStepHasHouse ?LordsId.
          filter (?LordsId IN (id:WkUWUBMx))}
        ?businessItem :businessItemHasWorkPackage ?workPackage.
        ?workPackage :workPackageHasProcedure ?procedure;
                     :workPackageHasWorkPackagedThing ?workPackagedThing.
        ?procedure :name ?procedureName.
        ?workPackagedThing :name ?workpackagedThingName. 

      } order by ?stepName ?procedureName ?workpackagedThingName
    "
  end
end