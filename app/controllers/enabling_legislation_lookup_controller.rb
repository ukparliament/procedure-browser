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
    
    puts "**********"
    puts enabling_legislation_show_path( legislation.id )
    puts enabling_legislation_show_url( legislation.id )
    puts request.base_url
    puts request.domain
    puts '====='
    puts Rails.application.routes.default_url_options[:host]
    puts routes.default_url_options[:host]
    puts "**********"
    
      # ... we redirect to the list of instruments before Parliament enabled by that legislation.
      redirect_to enabling_legislation_show_path( legislation.id )
    end
  end
end
