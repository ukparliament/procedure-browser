module Sparql::Queries::WorkPackageableThingByUri

  # A SPARQL query to get a work packageable thing by its legislation.gov.uk URI.
  def work_packageable_thing_by_uri_query( enabling_legislation_uri )
    "
      PREFIX : <https://id.parliament.uk/schema/>
      SELECT ?WorkPackagedThing
      WHERE {
        ?WorkPackagedThing a :WorkPackagedThing ;
        :workPackagedThingHasWorkPackagedThingWebLink
         <#{enabling_legislation_uri}> .
      }
    "
  end
end