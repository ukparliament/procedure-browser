class EnablingLegislationLookupController < ApplicationController

  # We include modules required to get an item of enabling legislation by its legislation.gov.uk URI.
  include Sparql::Get::EnablingLegislationByUri
  include Sparql::Queries::EnablingLegislationByUri
  include Sparql::Get::Response

  def index
  
    # We get the legislation.gov.uk URI from the parameters passed.
    legislation_gov_uk_uri = params['legislation-gov-uk-uri']
    
    # We attempt to find an item of legislation with this URI.
    legislation = get_enabling_legislation_by_uri( legislation_gov_uk_uri )
    
    # If we find an item of legislation with this URI ...
    if legislation

      Rails.logger.info "*" * 80
      Rails.logger.info "Here is some debug info"
      Rails.logger.info enabling_legislation_show_path( legislation.id )
      Rails.logger.info enabling_legislation_show_url( legislation.id )

      # ... we redirect to the list of instruments before Parliament enabled by that legislation.
      redirect_to enabling_legislation_show_path( legislation.id )
    end
  end
end
