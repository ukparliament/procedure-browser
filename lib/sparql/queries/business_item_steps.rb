module Sparql::Queries::BusinessItemSteps

# A SPARQL query to get steps for a business item.
  def business_item_steps_query( business_item_id )
    [
      # The title of the SPARQL query.
      "A list of a business item's steps",

      # The link to the SPARQL query.
      'https://api.parliament.uk/s/817d61bd',

      # The SPARQL query.
      "
# We declare the Parliament and ID namespaces.
PREFIX : <https://id.parliament.uk/schema/>
PREFIX id: <https://id.parliament.uk/>

# We select the properties we want to appear in results. If all properties are required, an asterisk can be used between SELECT and WHERE instead of listing properties.
SELECT ?businessItem ?workPackage ?workPackagedThing ?workPackagedThingLabel ?procedure ?procedureLabel ?calculationStyle ?calculationStyleLabel ?madeAvailableDate ?businessItemStep ?businessItemStepName ?stepDepth ?date ?url ?legislature ?legislatureName ?CommonsId ?LordsId
WHERE {

# We find all business items with their work package and steps. A business item may have one or more steps.
?businessItem a :BusinessItem;
:businessItemHasWorkPackage ?workPackage;
:businessItemHasProcedureStep ?businessItemStep.

# We filter the results to only include the business item with the requested ID.
FILTER (?businessItem in (id:#{business_item_id}))

# We look for names of the business item's steps.
?businessItemStep :name ?businessItemStepName.

# We check to see if the step belongs to a legislature. A legislature will be Scottish Parliament, Senedd Cymru or the Northern Ireland Assembly.
OPTIONAL 
{
  ?businessItemStep :procedureStepInLegislature ?legislature.
  ?legislature :name ?legislatureName.
}

# We check to see if the step belongs to the House of Commons.
OPTIONAL 
{
  ?businessItemStep :procedureStepHasHouse ?CommonsId.
  FILTER (?CommonsId IN (id:1AFu55Hs))
}

# We check to see if the step belongs to the House of Lords.
OPTIONAL 
{
  ?businessItemStep :procedureStepHasHouse ?LordsId.
  FILTER (?LordsId IN (id:WkUWUBMx))
}

# We check to see if the business item's step has a step depth within the procedure the work package is subject to, we then get that step depth. A business item or items may actualise two different business steps in the same work package on the same day. Because we capture dates rather than times of business items it was not possible to order business items in a way that made 'procedural sense', for example: we may have shown 'Procedure concluded' before 'Instrument approved'. procedureStepHasStepDisplayDepthInProcedure records the display depth of a business step forming part of the procedure, associating a display depth number with each step. For example: the 'Instrument created' business step in the draft affirmative procedure has a display depth of 1.0, whereas the 'Laid before the House of Commons' business step in the same procedure has a display depth of 3.1. These numbers are used to order business items in a work package sharing the same date.
OPTIONAL 
{
  ?businessItemStep :procedureStepHasStepDisplayDepthInProcedure ?businessItemStepDepth.
  ?businessItemStepDepth :stepDisplayDepthInProcedureHasProcedure ?procedure.
  ?businessItemStepDepth :stepDisplayDepthInProcedureHasDepth ?stepDepth.
}

# We look to see if the business item has a date. Not all business items will have a date, for example the 'Instrument comes into force' step.
OPTIONAL 
{
  ?businessItem :date ?date.
}

# We look to see if the business item has a web link.
OPTIONAL 
{
  ?businessItem :businessItemHasBusinessItemWebLink ?url
}

# We look for the work package's procedure and its work packaged thing. A work packaged thing is a paper laid before Parliament, for example a statutory instrument.
?workPackage :workPackageHasProcedure ?procedure;
:workPackageHasWorkPackagedThing ?workPackagedThing.

# We look for the procedure's name.
?procedure :name ?procedureLabel.

# We look for the work packaged thing's name.
?workPackagedThing :name ?workPackagedThingLabel.

# We specify that a work package may have a calculation style with its name but that a calculation style is not required.
OPTIONAL 
{
  ?workPackage :workPackageHasCalculationStyle ?calculationStyle.
  ?calculationStyle :name ?calculationStyleLabel.
}

# We check to see if the work package has a business item actualising a making available step with a date.
OPTIONAL 
{
  ?workPackage :workPackageHasBusinessItem ?bi.
  ?bi :businessItemHasProcedureStep ?procedureStep.
  ?bi :date ?madeAvailableDate.
  # We specify the making available steps that the business item should have. Making available steps will be one of the following: 'Laid before the House of Commons', 'Notification from Department announcing the publication of the draft laid before the House of Commons', 'Bill presented' (Commons) or 'Bill presented' (Lords).
  FILTER (?procedureStep in (id:cspzmb6w, id:isWn7s3K, id:ITNO9JWr, id:otscOTzB))
  }
}

# We order results by step depth.
ORDER BY ?stepDepth
      "
    ]
  end
end
