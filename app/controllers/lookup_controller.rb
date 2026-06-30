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
        # ... so we construct the ID-based legislation.gov.uk URI for the Act ...
        legislation_gov_uk_uri = lookup_uri.scheme
        legislation_gov_uk_uri += '://'
        legislation_gov_uk_uri += lookup_uri.host
        legislation_gov_uk_uri += '/id/'
        legislation_gov_uk_uri += path_items[1]
        legislation_gov_uk_uri += '/'
        legislation_gov_uk_uri += path_items[2]
        legislation_gov_uk_uri += '/'
        legislation_gov_uk_uri += path_items[3]
        
        # ... and redirect to the enabling legislation lookup URL.
        redirect_to enabling_legislation_lookup_list_url( 'legislation-gov-uk-uri'.to_sym => legislation_gov_uk_uri )
        
      # Otherwise, if the first item in the array is 'nisr' ...
      elsif path_items[1] == 'nisr'
      
        # ... we know we're looking for a Northern Ireland Statutory Rule ...
        # ... so we construct the lookup URL ....
        legislation_gov_uk_uri = lookup_uri.scheme
        legislation_gov_uk_uri += '://'
        legislation_gov_uk_uri += lookup_uri.host
        legislation_gov_uk_uri += '/'
        legislation_gov_uk_uri += path_items[1]
        legislation_gov_uk_uri += '/'
        legislation_gov_uk_uri += path_items[2]
        legislation_gov_uk_uri += '/'
        legislation_gov_uk_uri += path_items[3]
        legislation_gov_uk_uri += '/made'
        
        # ... and redirect to the work package thing lookup URI.
        redirect_to work_packageable_thing_lookup_list_url( 'legislation-gov-uk-uri'.to_sym => legislation_gov_uk_uri )
        
      # Otherwise, if the first item in the array is 'ukdsi' ...
      elsif path_items[1] == 'ukdsi'
      
        # ... we know we're looking for a draft statutory instrument ...
        # ... so we construct the lookup URL ....
        legislation_gov_uk_uri = lookup_uri.scheme
        legislation_gov_uk_uri += '://'
        legislation_gov_uk_uri += lookup_uri.host
        legislation_gov_uk_uri += '/'
        legislation_gov_uk_uri += path_items[1]
        legislation_gov_uk_uri += '/'
        legislation_gov_uk_uri += path_items[2]
        legislation_gov_uk_uri += '/'
        legislation_gov_uk_uri += path_items[3]
        
        # ... and redirect to the work package thing lookup URI.
        redirect_to work_packageable_thing_lookup_list_url( 'legislation-gov-uk-uri'.to_sym => legislation_gov_uk_uri )
        
      # Otherwise, if the first item in the array is 'uksi' ...
      elsif path_items[1] == 'uksi'
      
        # ... we know we're looking for what is now a made statutory instrument ...
        # ... so we construct the lookup URL ....
        legislation_gov_uk_uri = lookup_uri.scheme
        legislation_gov_uk_uri += '://'
        legislation_gov_uk_uri += lookup_uri.host
        legislation_gov_uk_uri += '/'
        legislation_gov_uk_uri += path_items[1]
        legislation_gov_uk_uri += '/'
        legislation_gov_uk_uri += path_items[2]
        legislation_gov_uk_uri += '/'
        legislation_gov_uk_uri += path_items[3]
        legislation_gov_uk_uri += '/made'
        
        # Given this is now a made statutory instrument, it may have either been:
        # * laid as made
        # * laid in draft and made later
        # * laid as a type II made affirmative, in which case the URL may change once approved by Parliament.
        
        # We need to check if this made instrument supersedes another instrument ...
        # ... so we get the URL of the XML description of the made instrument.
        made_instrument_xml_url = legislation_gov_uk_uri + '/data.xml'
        
        # We get the XML description of the made instrument.
        doc = Nokogiri::XML( URI.open( made_instrument_xml_url ) )
        
        # We set the legislation.gov.uk metadata namespace.
        namespace = { 'ukm' => 'http://www.legislation.gov.uk/namespaces/metadata' }
        
        # We attempt to find the URL of the superseded draft instrument.
        # If there is a Superseded URI in the XML ...
        unless doc.xpath( '//ukm:Supersedes/@URI', namespace ).empty?
        
          # ... we store the URL of the superseded draft instrument.
          superseded_draft_instrument_url = doc.xpath( '//ukm:Supersedes/@URI', namespace ).first.value
        end
        
        # If there is a superseded draft instrument URL ...
        if !superseded_draft_instrument_url.blank?
        
          # ... we set the legislation.gov.uk URI to the superseded draft instrument URL.
          legislation_gov_uk_uri = superseded_draft_instrument_url
          
          # We substitute 'http://' with 'https://'.
          legislation_gov_uk_uri.gsub!( 'http://', 'https://' )
          
          # We update the legislation.gov.uk URL from the non-information resource, ID-based URI to the information resource URL ...
          # ... by substituting '/id/' for '/'.
          legislation_gov_uk_uri.gsub!( '/id/', '/' )
        end
        
        # We redirect to the work package thing lookup URI.
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
      
    # Otherwise, if the host of the URI passed as a parameter is not www.legislation.gov.uk
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
