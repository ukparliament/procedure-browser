xml.rss( :version => '2.0', 'xmlns:atom' => 'http://www.w3.org/2005/Atom' ) do
	xml.channel do
	    xml.title( "Reading list for a work package focussed on #{@work_package.work_packageable_thing_label}." )
	    xml.description( "Updates whenever a new document is added." )
		xml.link( work_package_reading_list_list_url )
	    xml.copyright( 'https://www.parliament.uk/site-information/copyright-parliament/open-parliament-licence/' )
	    xml.language( 'en-uk' )
	    xml.pubDate( @business_items.first.date.rfc822 ) unless @business_items.empty? or @business_items.first.date.nil?
	    xml.tag!( 'atom:link', { :href => work_package_reading_list_list_url( :format => 'rss' ), :rel => 'self', :type => 'application/rss+xml' } )
		@business_items.each do |date|
			xml << render(:partial => 'business_item', :collection => @business_items ) unless @business_items.empty?
		end
	end
end