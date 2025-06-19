module Sparql::Queries::OrganisationsAccountableToParliamentCurrent

  # A SPARQL query to get current organisations accountable to Parliament taking parameters of limit and offset.
  def organisations_accountable_to_parliament_current_query( limit, offset )
    "
      PREFIX : <https://id.parliament.uk/schema/>
           PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
           PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
           PREFIX id: <https://id.parliament.uk/>
           SELECT * WHERE {
            { ?Organisations a :GovernmentOrganisation.}
            UNION {
           ?Organisations a :ArmsLengthBody.
                           }
             ?Organisations :name ?Name.
  
             optional {?Organisations :startDate ?startDate}
         minus {?Organisations :endDate ?endDate}
  
           } order by ?Name

           limit #{limit} offset #{offset}
    "
  end
end
