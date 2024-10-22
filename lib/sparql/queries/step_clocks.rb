module Sparql::Queries::StepClocks

  # A SPARQL query to get clocks for a step.
  def step_clocks_query( step_id )
    "
      PREFIX id: <https://id.parliament.uk/>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      SELECT ?procedure ?procedureLabel  ?clocks ?clockLabel ?dayCount  ?StartStep ?StartStepName ?StartStepType ?StartStepTypeName ?StartStepCommonsId ?StartStepLordsId ?StartSteplegislature ?StartSteplegislatureName ?EndStep ?EndStepName ?EndStepType ?EndStepTypeName ?EndStepCommonsId ?EndStepLordsId ?EndSteplegislature ?EndSteplegislatureName	WHERE {

        ?Step a :ProcedureStep;
                  :name ?stepName.
          filter (?Step IN (id:#{step_id}))
          ?Step :startProcedureStepOfClock | :endProcedureStepOfClock ?clocks.
         ?clocks :clockFormsPartOfProcedure ?procedure;
                 rdfs:label ?clockLabel.
        optional {?clocks  :clockDayCount ?dayCount}
        ?procedure :name ?procedureLabel.
        ?clocks :clockHasStartProcedureStep ?StartStep.
        ?StartStep :name ?StartStepName;
                   :procedureStepHasProcedureStepType ?StartStepType.
          ?StartStepType :name ?StartStepTypeName. 
        ?clocks :clockHasEndProcedureStep ?EndStep.
        ?EndStep :name ?EndStepName;
                 :procedureStepHasProcedureStepType ?EndStepType.
          ?EndStepType :name ?EndStepTypeName.
      optional {?StartStep :procedureStepInLegislature ?StartSteplegislature.
                ?StartSteplegislature :name ?StartSteplegislatureName.}
              optional {?StartStep :procedureStepHasHouse ?StartStepCommonsId.
                    filter (?StartStepCommonsId IN (id:1AFu55Hs))}
              optional {?StartStep :procedureStepHasHouse ?StartStepLordsId.
          filter (?StartStepLordsId IN (id:WkUWUBMx))}
        optional {?EndStep :procedureStepInLegislature ?EndSteplegislature.
                ?EndSteplegislature :name ?EndSteplegislatureName.}
              optional {?EndStep :procedureStepHasHouse ?EndStepCommonsId.
                    filter (?EndStepCommonsId IN (id:1AFu55Hs))}
              optional {?EndStep :procedureStepHasHouse ?EndStepLordsId.
          filter (?EndStepLordsId IN (id:WkUWUBMx))}
      }
    "
  end
end