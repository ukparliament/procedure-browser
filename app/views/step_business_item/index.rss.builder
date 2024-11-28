xml.rss( :version => '2.0', 'xmlns:atom' => 'http://www.w3.org/2005/Atom' ) do
  xml.channel do
    xml.title( "Business items actualising the '#{@step.label}' step in their work packages." )
    xml.description( "Updates whenever the work package for a paper has a business item actualising the step '#{@step.label}'." )
	xml.link( step_business_item_list_url )
    xml.copyright( 'https://www.parliament.uk/site-information/copyright-parliament/open-parliament-licence/' )
    xml.language( 'en-uk' )
    xml.pubDate( @step_business_items.first.date.rfc822 ) unless @step_business_items.empty?
    xml.tag!( 'atom:link', { :href => step_business_item_list_url( :format => 'rss' ), :rel => 'self', :type => 'application/rss+xml' } )
    xml << render(:partial => 'business_item', :collection => @step_business_items, :locals => { :step => @step } ) unless @step_business_items.empty?
  end
end