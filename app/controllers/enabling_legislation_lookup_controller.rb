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
    
      # ... we redirect to the list of instruments before Parliament enabled by that legislation.
      redirect_to enabling_legislation_show_path( legislation.id )
      
    # Otherwise, if we do not find an item of legislation with this URI ...
    else
      
      # ... we set the not found page meta information ...
      @page_title = 'Enabling legislation not found'
      @multiline_page_title = "Enabling legislation <span class='subhead'>Not found</span>".html_safe
      @description = 'We were unable to find that item of enabling legislation.'
      @crumb << { label: 'Enabling legislation', url: enabling_legislation_list_url }
      @crumb << { label: 'Not found', url: nil }
      @section = 'enabling-legislation'
      
      # ... and render the not found template, returning a status code of 404.
      render template: "enabling_legislation_lookup/not_found", status: :not_found, layout: true
    end
  end
end
