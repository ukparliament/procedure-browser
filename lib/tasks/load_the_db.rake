namespace :load do

  desc "Load everything"
  task all: [:organisations, :enabling_legislations, :work_packages, :steps]

  desc "load organisations"
  task organisations: :environment do
    include Sparql::Get::OrganisationsAccountableToParliamentAll
    include Sparql::Queries::OrganisationsAccountableToParliamentAll
    include Sparql::Get::Response

    pp "Load organisations"
    @queries = []

    OrganisationAccountableToParliament.delete_all

    get_organisations_accountable_to_parliament_all.each(&:save)

    pp "Loaded organisations"
  end

  desc "load enabling legislation"
  task enabling_legislations: :environment do

    include Sparql::Get::EnablingLegislations
    include Sparql::Queries::EnablingLegislations
    include Sparql::Get::Response

    pp "Load enabling legislations"
    @queries = []

    EnablingLegislation.delete_all

    get_enabling_legislations.each(&:save)
    pp "Loaded enabling legislations"
  end

  desc "load work packages"
  task work_packages: :environment do
    include Sparql::Get::WorkPackagesAll
    include Sparql::Queries::WorkPackagesAll
    include Sparql::Get::Response

    pp "Load work packages"

    @queries = []

    WorkPackage.delete_all

    get_work_packages_all.each(&:save)
    pp "Loaded work packages"
  end

  desc "load steps"
  task steps: :environment do
    include Sparql::Get::Steps
    include Sparql::Queries::Steps
    include Sparql::Get::Response

    pp "Load steps"

    @queries = []

    Step.delete_all

    get_steps.each(&:save)
    pp "Loaded steps"
  end
end
