xml.rss( :version => '2.0', 'xmlns:atom' => 'http://www.w3.org/2005/Atom' ) do
	xml.channel do
	    xml.title( "Business items for a work package focussed on #{@work_package.work_packageable_thing_label}." )
	    xml.description( "Updates whenever a new business item is added." )
		xml.link( work_package_business_item_list_url )
	    xml.copyright( 'https://www.parliament.uk/site-information/copyright-parliament/open-parliament-licence/' )
	    xml.language( 'en-uk' )
	    xml.pubDate( @work_package_dated_business_items.first.first.first.date.rfc822 ) unless @work_package_dated_business_items.empty?
	    xml.tag!( 'atom:link', { :href => work_package_business_item_list_url( :format => 'rss' ), :rel => 'self', :type => 'application/rss+xml' } )
		@work_package_dated_business_items.each do |date|
			xml << render(:partial => 'business_item', :collection => date ) unless @work_package_dated_business_items.empty?
		end
	end
end