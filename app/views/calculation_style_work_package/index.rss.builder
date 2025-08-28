xml.rss( :version => '2.0', 'xmlns:atom' => 'http://www.w3.org/2005/Atom' ) do
  xml.channel do
    xml.title( "Work packages with the '#{@calculation_style.label}' calculation style." )
    xml.description( "Updates whenever a new work package is added." )
	xml.link( calculation_style_work_package_list_url )
    xml.copyright( 'https://www.parliament.uk/site-information/copyright-parliament/open-parliament-licence/' )
    xml.language( 'en-uk' )
    xml.pubDate( @calculation_style_work_packages.first.made_available_on.rfc822 ) unless @calculation_style_work_packages.empty? or @calculation_style_work_packages.first.made_available_on.nil?
    xml.tag!( 'atom:link', { :href => calculation_style_work_package_list_url( :format => 'rss' ), :rel => 'self', :type => 'application/rss+xml' } )
   	xml << render(:partial => 'work_package/work_package', :collection => @calculation_style_work_packages ) unless @calculation_style_work_packages.empty?
  end
end