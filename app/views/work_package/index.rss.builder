xml.rss( :version => '2.0', 'xmlns:atom' => 'http://www.w3.org/2005/Atom' ) do
  xml.channel do
    xml.title( "Work packages." )
    xml.description( "Updates whenever a new work package is created." )
	xml.link( work_package_list_url )
    xml.copyright( 'https://www.parliament.uk/site-information/copyright-parliament/open-parliament-licence/' )
    xml.language( 'en-uk' )
    xml.pubDate( @work_packages.first.made_available_on.rfc822 ) unless @work_packages.empty? or @work_packages.first.made_available_on.nil?
    xml.tag!( 'atom:link', { :href => work_package_list_url( :format => 'rss' ), :rel => 'self', :type => 'application/rss+xml' } )
    xml << render(:partial => 'work_package', :collection => @work_packages ) unless @work_packages.empty?
  end
end