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
    
    # If we find the item of legislation ...
    if legislation
    
      # ... we redirect to the list of instruments before Parliament enabled by that legislation.
      redirect_to enabling_legislation_show_url( :enabling_legislation => legislation.id ), :status => 301
      
    # Otherwise, if we fail to find the item of legislation ...
    else
    
      # ... we raise a 404.
      raise ActiveRecord::RecordNotFound
    end
  end
end
