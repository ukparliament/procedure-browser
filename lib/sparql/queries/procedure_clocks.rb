module Sparql::Queries::ProcedureClocks

  # A SPARQL query to get clocks for a procedure.
  def procedure_clocks_query( procedure_id )
    "
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX id: <https://id.parliament.uk/>
      SELECT * WHERE {
        ?Procedure a :Procedure;
                   :name ?ProcedureName.
         filter (?Procedure in (id:#{procedure_id}))
        ?Procedure :procedureHasClock ?Clock. 
        ?Clock :clockLabel ?ClockLabel.
        optional {?Clock :clockDayCount ?ClockDayCount.}
                  ?Clock :clockHasStartProcedureStep ?StartStep. 
        ?StartStep :name ?StartStepName;
                  :procedureStepHasProcedureStepType ?StartStepType.
        ?StartStepType :name ?StartStepTypeName. 
          Optional {?StartStep :procedureStepInLegislature ?StartSteplegislature.
          ?StartSteplegislature :name ?StartSteplegislatureName.}
          Optional {?StartStep:procedureStepHasHouse ?StartStepCommonsId
          filter (?StartStepCommonsId IN (id:1AFu55Hs))}
          Optional {?StartStep :procedureStepHasHouse ?StartStepLordsId.
            filter (?StartStepLordsId IN (id:WkUWUBMx))}
          ?Clock :clockHasEndProcedureStep ?EndStep. 
        ?EndStep :name ?EndStepName;
                  :procedureStepHasProcedureStepType ?EndStepType.
        ?EndStepType :name ?EndStepTypeName. 
        Optional {?EndStep :procedureStepInLegislature ?EndSteplegislature.
          ?EndSteplegislature :name ?EndSteplegislatureName.}
          Optional {?EndStep:procedureStepHasHouse ?EndStepCommonsId
          filter (?EndStepCommonsId IN (id:1AFu55Hs))}
          Optional {?EndStep :procedureStepHasHouse ?EndStepLordsId.
            filter (?EndStepLordsId IN (id:WkUWUBMx))}
  
        }
    "
  end
end