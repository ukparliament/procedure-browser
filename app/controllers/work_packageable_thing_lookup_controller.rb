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
    end
  end
end
