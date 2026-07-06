xml.rss( :version => '2.0', 'xmlns:atom' => 'http://www.w3.org/2005/Atom' ) do
	xml.channel do
	    xml.title( "Documents for a work package focussed on #{@work_package.work_packageable_thing_label}." )
	    xml.description( "Updates whenever a new document is added." )
		xml.link( work_package_document_list_url )
	    xml.copyright( 'https://www.parliament.uk/site-information/copyright-parliament/open-parliament-licence/' )
	    xml.language( 'en-uk' )
	    xml.pubDate( @documents.first.date.rfc822 ) unless @documents.empty? or @documents.first.date.nil?
	    xml.tag!( 'atom:link', { :href => work_package_document_list_url( :format => 'rss' ), :rel => 'self', :type => 'application/rss+xml' } )
		@documents.each do |document|
			xml << render(:partial => 'document', :collection => @documents ) unless @documents.empty?
		end
	end
end