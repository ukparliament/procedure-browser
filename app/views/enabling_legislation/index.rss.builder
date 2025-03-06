xml.rss( :version => '2.0', 'xmlns:atom' => 'http://www.w3.org/2005/Atom' ) do
  xml.channel do
  	xml.title( "Enabling legislation." )
	xml.description( "Updates whenever a new item of enabling legislation is created." )
	xml.link( enabling_legislation_list_url )
	xml.copyright( 'https://www.parliament.uk/site-information/copyright-parliament/open-parliament-licence/' )
	xml.language( 'en-uk' )
	xml.pubDate( @enabling_legislations.first.date.rfc822 ) unless @enabling_legislations.empty?
	xml.tag!( 'atom:link', { :href => enabling_legislation_list_url( :format => 'rss' ), :rel => 'self', :type => 'application/rss+xml' } )
	xml << render(:partial => 'enabling_legislation', :collection => @enabling_legislations ) unless @enabling_legislations.empty?
  end
end