xml.rss( :version => '2.0', 'xmlns:atom' => 'http://www.w3.org/2005/Atom' ) do
	xml.channel do
	    xml.title( "Events for the work package focussed on #{@work_package.work_packageable_thing_label}." )
	    xml.description( "Updates whenever a new work event is added." )
		xml.link( work_package_event_list_url )
	    xml.copyright( 'https://www.parliament.uk/site-information/copyright-parliament/open-parliament-licence/' )
	    xml.language( 'en-uk' )
	    xml.pubDate( @work_package_dated_events.first.first.first.date.rfc822 ) unless @work_package_dated_events.empty?
	    xml.tag!( 'atom:link', { :href => work_package_event_list_url( :format => 'rss' ), :rel => 'self', :type => 'application/rss+xml' } )
		@work_package_dated_events.each do |date|
			xml << render(:partial => 'event', :collection => date ) unless @work_package_dated_events.empty?
		end
	end
end