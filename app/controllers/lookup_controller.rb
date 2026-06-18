class LookupController < ApplicationController

  def index
  
    # We get the legislation.gov.uk URI from the parameters passed.
    legislation_gov_uk_uri = params['legislation-gov-uk-uri']
    
    # We attempt to parse the URI passed as a parameter.
    lookup_uri = URI.parse( legislation_gov_uk_uri )
    
    # If the host of the URI passed as a parameter is www.legislation.gov.uk ...
    if lookup_uri.host == 'www.legislation.gov.uk'
    
      # ... we create an array of items in the path.
      path_items = lookup_uri.path.split( '/' )
      
      # If the second item in the array is 'ukpga' ...
      if path_items[1] == 'ukpga'
      
        # ... we know we're looking for a public general Act ...
        # ... so we construct the ID-based legsilation.gov.uk URI for the Act ...
        legislation_gov_uk_uri = lookup_uri.scheme + '://' + lookup_uri.host + '/id/' + path_items[1] + '/' + path_items[2] + '/'  + path_items[3]
        
        # ... and redirect to the enabling legislation lookup URL.
        redirect_to enabling_legislation_lookup_list_url( 'legislation-gov-uk-uri'.to_sym => legislation_gov_uk_uri )
        
      # Otherwise, if the second item in the array is 'uksi' *or* 'ukdsi' or 'nisr' ...
      elsif ( path_items[1] == 'uksi' ) or ( path_items[1] == 'ukdsi' ) or  ( path_items[1] == 'nisr' )
      
        # ... we know we're looking for a made statutory instrument or a draft statutory instrument ...
        # ... so we redirect to the work package thing lookup URI.
        redirect_to work_packageable_thing_lookup_list_url( 'legislation-gov-uk-uri'.to_sym => legislation_gov_uk_uri )
        
      # Otherwise, if the second item is neither 'ukpga', 'uksi', 'ukdsi' or 'nisr' ...
      else
      
        # ... we set the not found page meta information ...
        @page_title = 'Not found'
        @description = 'We were unable to find that record.'
        @crumb << { label: 'Not found', url: nil }
      
        # ... and render the not found template, returning a status code of 404.
        render template: "lookup/not_found", status: :not_found, layout: true
      end
    end
  end
end
