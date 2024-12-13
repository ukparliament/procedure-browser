xml.rss( :version => '2.0', 'xmlns:atom' => 'http://www.w3.org/2005/Atom' ) do
  xml.channel do
    xml.title( "Business items actualising the '#{@procedure_step.label}' step in the '#{@procedure.label}' procedure." )
    xml.description( "Updates whenever the work package for a paper has a business item actualising the step '#{@procedure_step.label}' as part of the '#{@procedure.label}' procedure." )
	xml.link( procedure_step_business_item_list_url )
    xml.copyright( 'https://www.parliament.uk/site-information/copyright-parliament/open-parliament-licence/' )
    xml.language( 'en-uk' )
    xml.pubDate( @procedure_step_business_items.first.date.rfc822 ) unless @procedure_step_business_items.empty?
    xml.tag!( 'atom:link', { :href => procedure_step_business_item_list_url( :format => 'rss' ), :rel => 'self', :type => 'application/rss+xml' } )
    xml << render( :partial => 'business_item', :collection => @procedure_step_business_items ) unless @procedure_step_business_items.empty?
  end
end