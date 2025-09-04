module Sparql::Queries::EnablingLegislationAtozLetter

  # A SPARQL query to get a list of enabling legislation starting with a given letter.
  def enabling_legislation_atoz_letter_query( letter )
    "
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX id: <https://id.parliament.uk/>

      SELECT DISTINCT ?EnablingThing ?Name ?Number ?Year ?Date ?URL WHERE {
        ?EnablingThing a :EnablingThing;  
                       :enabling ?EnabledThing.
        OPTIONAL { ?EnablingThing :actOfParliamentName ?Name. }
        OPTIONAL { ?EnablingThing :actOfParliamentNumber ?Number. }
        OPTIONAL { ?EnablingThing :actOfParliamentYear ?Year. }
        OPTIONAL { ?EnablingThing :actOfParliamentRoyalAssentDate ?Date. }
        OPTIONAL { ?EnablingThing :actOfParliamentUrl ?URL. }
        ?EnabledThing :name ?EnabledThingName.

        FILTER regex(str(?Name), '^#{letter}', 'i')
      }
      ORDER BY ?Name
    "
  end
end
