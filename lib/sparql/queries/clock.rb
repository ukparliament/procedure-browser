module Sparql::Queries::Clock

  # A SPARQL query to get a clock.
  def clock_query( clock_id )
    "
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX id: <https://id.parliament.uk/>
      SELECT ?Clock ?ClockName ?DayCount ?procedure ?procedureName ?StartStep ?StartStepName ?StartStepType ?StartStepTypeName ?StartSteplegislature ?StartSteplegislatureName ?StartStepCommonsId ?StartStepLordsId ?EndStep ?EndStepName ?EndStepType ?EndStepTypeName ?EndSteplegislature ?EndSteplegislatureName ?EndStepCommonsId ?EndStepLordsId WHERE {
        ?Clock a :Clock;
                   :name ?ClockName;
                   :clockFormsPartOfProcedure ?procedure;
                   :clockHasStartProcedureStep ?StartStep;
                   :clockHasEndProcedureStep ?EndStep. 
  optional {?Clock :clockDayCount ?DayCount.}
  filter (?Clock in (id:#{clock_id}))
                   ?procedure :name ?procedureName.
  			    ?StartStep :name ?StartStepName;
            :procedureStepHasProcedureStepType ?StartStepType.
  ?StartStepType :name ?StartStepTypeName. 
    Optional {?StartStep :procedureStepInLegislature ?StartSteplegislature.
    ?StartSteplegislature :name ?StartSteplegislatureName.}
    Optional {?StartStep:procedureStepHasHouse ?StartStepCommonsId
    filter (?StartStepCommonsId IN (id:1AFu55Hs))}
    Optional {?StartStep :procedureStepHasHouse ?StartStepLordsId.
      filter (?StartStepLordsId IN (id:WkUWUBMx))}
     ?EndStep :name ?EndStepName;
            :procedureStepHasProcedureStepType ?EndStepType.
  ?EndStepType :name ?EndStepTypeName. 
  Optional {?EndStep :procedureStepInLegislature ?EndSteplegislature.
    ?EndSteplegislature :name ?EndSteplegislatureName.}
    Optional {?EndStep:procedureStepHasHouse ?EndStepCommonsId
    filter (?EndStepCommonsId IN (id:1AFu55Hs))}
    Optional {?EndStep :procedureStepHasHouse ?EndStepLordsId.
      filter (?EndStepLordsId IN (id:WkUWUBMx))}
              } Order by ?ClockName ?procedureName
    "
  end
end