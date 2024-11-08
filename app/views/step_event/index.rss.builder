xml.rss( :version => '2.0', 'xmlns:atom' => 'http://www.w3.org/2005/Atom' ) do
  xml.channel do
    xml.title( "Events actualising the '#{@step.label}' step in their work packages." )
    xml.description( "Updates whenever the work package for a paper has an event actualising the step '#{@step.label}'." )
	xml.link( step_event_list_url )
    xml.copyright( 'https://www.parliament.uk/site-information/copyright-parliament/open-parliament-licence/' )
    xml.language( 'en-uk' )
    xml.pubDate( @step_events.first.date.rfc822 ) unless @step_events.empty?
    xml.tag!( 'atom:link', { :href => step_event_list_url( :format => 'rss' ), :rel => 'self', :type => 'application/rss+xml' } )
    xml << render(:partial => 'event', :collection => @step_events, :locals => { :step => @step } ) unless @step_events.empty?
  end
end