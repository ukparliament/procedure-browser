namespace :load do
  desc "load organisations"
  task organisations: :environment do
    include Sparql::Get::OrganisationsAccountableToParliamentAll
    include Sparql::Queries::OrganisationsAccountableToParliamentAll
    include Sparql::Get::Response

    $SPARQL_REQUEST_URI = URI( 'https://api.parliament.uk/sparql' )
    $SPARQL_REQUEST_HEADERS = { 'Content-Type': 'application/sparql-query' }

    @queries = []

    OrganisationAccountableToParliament.delete_all

    orgs = get_organisations_accountable_to_parliament_all
    orgs.each { |organisation| organisation.save }
  end
end
