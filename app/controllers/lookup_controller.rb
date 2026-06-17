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
        
      # Otherwise, if the second item in the array is 'uksi' *or* 'ukdsi' ...
      elsif path_items[1] == 'uksi' or path_items[1] == 'ukdsi'
      
        # ... we know we're looking for a made statutory instrument or a draft statutory instrument ...
        # ... so we redirect to the work package thing lookup URI.
        redirect_to work_packageable_thing_lookup_list_url( 'legislation-gov-uk-uri'.to_sym => legislation_gov_uk_uri )
      end
    end
  end
end
