class WorkPackageableThingLookupController < ApplicationController

  # We include modules required to get a work packageable thing by its legislation.gov.uk URI.
  include Sparql::Get::WorkPackageableThingByUri
  include Sparql::Queries::WorkPackageableThingByUri
  include Sparql::Get::Response

  def index
  
    # We get the legislation.gov.uk URI from the parameters passed.
    legislation_gov_uk_uri = params['legislation-gov-uk-uri']
    
    # We attempt to find a work packageable thing with this URI.
    work_packageable_thing = get_work_packageable_thing_by_uri( legislation_gov_uk_uri )
    
    # If we find a work packageable thing with this URI ...
    if work_packageable_thing
    
      # ... we redirect to the work packageable thing.
      redirect_to work_packageable_thing_show_path( work_packageable_thing.id )
      
    # Otherwise, if we do not find a work packageable thing with this URI ...
    else
      
      # ... we set the not found page meta information ...
      @page_title = 'Work packageable thing not found'
      @multiline_page_title = "Work packageable thing <span class='subhead'>Not found</span>".html_safe
      @description = 'We were unable to find that work packageable thing.'
      @crumb << { label: 'Work packageable things', url: work_packageable_thing_list_url }
      @crumb << { label: 'Not found', url: nil }
      @section = 'work-packages'
      
      # ... and render the not found template, returning a status code of 404.
      render template: "work_packageable_thing_lookup/not_found", status: :not_found, layout: true
    end
  end
end
