module Sparql::Queries::EnablingLegislationAtoz

  # A SPARQL query to get an A to Z of enabling legislation.
  def enabling_legislation_atoz_query
    "
      PREFIX : <https://id.parliament.uk/schema/>
      PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX id: <https://id.parliament.uk/>

      SELECT ?FirstLetter (COUNT(DISTINCT ?EnablingThing) AS ?Count)
      WHERE {
        ?EnablingThing a :EnablingThing;
                       :enabling ?EnabledThing.
        OPTIONAL { ?EnablingThing :actOfParliamentName ?Name. }

        BIND(UCASE(SUBSTR(STR(?Name), 1, 1)) AS ?FirstLetter)
      }
      GROUP BY ?FirstLetter
      ORDER BY ?FirstLetter
    "
  end
end
