module Sparql::Queries::Clocks

  # A SPARQL query to get all clocks.
  def clocks_query
    [
      # The title of the SPARQL query.
      "A list of clocks",

      # The link to the SPARQL query.
      'https://api.parliament.uk/s/0941c559',

      # The SPARQL query.
    "
# We declare the Parliament and ID namespaces.      
PREFIX : <https://id.parliament.uk/schema/>
PREFIX id: <https://id.parliament.uk/>

# We select the properties we want to appear in results.
# If all properties are required, an asterisk can be used between SELECT and WHERE instead of listing properties.
SELECT ?clock ?clockName ?dayCount ?procedure ?procedureName ?startStep ?startStepName ?startStepType ?startStepTypeName ?startSteplegislature ?startSteplegislatureName ?startStepCommonsId ?startStepLordsId ?endStep ?endStepName ?endStepType ?endStepTypeName ?endSteplegislature ?endSteplegislatureName ?endStepCommonsId ?endStepLordsId WHERE {

  # We find all the clocks and their names, the procedures they form part of and their start and end procedure steps.  
  ?clock a :Clock;
  :name ?clockName;
  :clockFormsPartOfProcedure ?procedure;
  :clockHasStartProcedureStep ?startStep;
  :clockHasEndProcedureStep ?endStep. 

  # We specify that the clock may, or may not, have a day count.
  OPTIONAL {
    ?clock :clockDayCount ?dayCount.
  }
  
  # We specify the procedure's name
  ?procedure :name ?procedureName.

  # We specify the start procedure step's name, step type and the step type's name.
  ?startStep :name ?startStepName;
  :procedureStepHasProcedureStepType ?startStepType.
  ?startStepType :name ?startStepTypeName. 

  # We check to see if the start step belongs to a legislature.
  # A legislature will be Scottish Parliament, Senedd Cymru or the Northern Ireland Assembly.
  OPTIONAL {
    ?startStep :procedureStepInLegislature ?startSteplegislature.
    ?startSteplegislature :name ?startSteplegislatureName.
  }
  
  # We check to see if the start step belongs to the House of Commons.
  OPTIONAL {
    ?startStep:procedureStepHasHouse ?startStepCommonsId
    FILTER ( ?startStepCommonsId IN ( id:1AFu55Hs ) )
  }
  
  # We check to see if the start step belongs to the House of Lords.
  OPTIONAL {
    ?startStep :procedureStepHasHouse ?startStepLordsId.
    FILTER ( ?startStepLordsId IN ( id:WkUWUBMx ) )
  }

  # We specify the end procedure step's name, step type and the step type's name.  
  ?endStep :name ?endStepName;
  :procedureStepHasProcedureStepType ?endStepType.
  ?endStepType :name ?endStepTypeName. 

  # We check to see if the end step belongs to a legislature.
  # A legislature will be Scottish Parliament, Senedd Cymru or the Northern Ireland Assembly.
  OPTIONAL {
    ?endStep :procedureStepInLegislature ?endSteplegislature.
    ?endSteplegislature :name ?endSteplegislatureName.
  }
  
  # We check to see if the end step belongs to the House of Commons.
  OPTIONAL {
    ?endStep:procedureStepHasHouse ?endStepCommonsId
    FILTER ( ?endStepCommonsId IN ( id:1AFu55Hs ) )
  }

  # We check to see if the end step belongs to the House of Lords.
  OPTIONAL {
    ?endStep :procedureStepHasHouse ?endStepLordsId.
    FILTER ( ?endStepLordsId IN ( id:WkUWUBMx ) )
  }
} 
# We order results by the name of the clock, and then by the name of the procedure.  
ORDER BY ?clockName ?procedureName
    "
  ]
  end
end