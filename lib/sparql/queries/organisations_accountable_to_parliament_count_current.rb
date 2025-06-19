module Sparql::Queries::OrganisationsAccountableToParliamentCountCurrent

  # A SPARQL query to get a count of current organisations accountable to Parliament.
  def organisations_accountable_to_parliament_count_current_query
    "
      PREFIX : <https://id.parliament.uk/schema/>
           PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
           PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
           PREFIX id: <https://id.parliament.uk/>
           SELECT distinct (count(distinct ?Organisations) as ?count) WHERE {
            { ?Organisations a :GovernmentOrganisation.}
            UNION {
           ?Organisations a :ArmsLengthBody.
                           }
             ?Organisations :name ?Name.
  
             optional {?Organisations :startDate ?startDate}
         minus {?Organisations :endDate ?endDate}
  
           }
    "
  end
end
