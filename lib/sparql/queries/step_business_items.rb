module Sparql::Queries::StepBusinessItems

  # A SPARQL query to get business items for a step.
  def step_business_items_query( step_id )
    "
      PREFIX id: <https://id.parliament.uk/>
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      SELECT ?businessItem ?businessItemDate ?workPackage ?procedure ?procedureName ?workPackagedThing ?workpackagedThingName WHERE {

        ?Step a :ProcedureStep;
                  :name ?stepName;
                  :procedureStepHasBusinessItem ?businessItem.
          filter (?Step IN (id:#{step_id}))
        optional{ ?businessItem :businessItemDate ?businessItemDate.}
        optional {?businessItem :businessItemHasBusinessItemWebLink ?businessItemLink }
        ?businessItem :businessItemHasWorkPackage ?workPackage.
        ?workPackage :workPackageHasProcedure ?procedure;
                     :workPackageHasWorkPackagedThing ?workPackagedThing.
        ?procedure :name ?procedureName.
        ?workPackagedThing :name ?workpackagedThingName. 
      } order by DESC(?businessItemDate)  ?workpackagedThingName
    "
  end
end