namespace :load do
  desc "load organisations"
  task organisations: :environment do
    include Sparql::Get::OrganisationsAccountableToParliamentAll
    include Sparql::Queries::OrganisationsAccountableToParliamentAll
    include Sparql::Get::Response

    @queries = []

    OrganisationAccountableToParliament.delete_all

    orgs = get_organisations_accountable_to_parliament_all
    orgs.each { |organisation| organisation.save }
  end

  desc "load enabling legislation"
  task enabling_legislations: :environment do

    include Sparql::Get::EnablingLegislations
    include Sparql::Queries::EnablingLegislations
    include Sparql::Get::EnablingLegislation
    include Sparql::Queries::EnablingLegislation
    include Sparql::Get::EnablingLegislationWorkPackageCountCurrent
    include Sparql::Queries::EnablingLegislationWorkPackageCountCurrent
    include Sparql::Get::EnablingLegislationWorkPackagesCurrent
    include Sparql::Queries::EnablingLegislationWorkPackagesCurrent
    include Sparql::Get::Response

    @queries = []

    EnablingLegislation.delete_all

    enabling_legislations = get_enabling_legislations
    enabling_legislations.each { |enabling_legislation| enabling_legislation.save }
  end

  desc "load work packages"
  task work_packages: :environment do
    include Sparql::Get::OrganisationsAccountableToParliamentAll
    include Sparql::Queries::OrganisationsAccountableToParliamentAll
    include Sparql::Get::Response

    @queries = []

    OrganisationAccountableToParliament.delete_all

    orgs = get_organisations_accountable_to_parliament_all
    orgs.each { |organisation| organisation.save }
  end

  desc "load steps"
  task steps: :environment do
    include Sparql::Get::OrganisationsAccountableToParliamentAll
    include Sparql::Queries::OrganisationsAccountableToParliamentAll
    include Sparql::Get::Response

    @queries = []

    OrganisationAccountableToParliament.delete_all

    orgs = get_organisations_accountable_to_parliament_all
    orgs.each { |organisation| organisation.save }
  end
end
