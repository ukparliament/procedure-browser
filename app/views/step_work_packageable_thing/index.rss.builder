xml.rss( :version => '2.0', 'xmlns:atom' => 'http://www.w3.org/2005/Atom' ) do
  xml.channel do
    xml.title( "Papers actualising the '#{@step.label}' step in their work packages." )
    xml.description( "Updates whenever the work package for a paper has step '#{@step.label}'." )
	xml.link( step_work_packageable_thing_list_url )
    xml.copyright( 'https://www.parliament.uk/site-information/copyright-parliament/open-parliament-licence/' )
    xml.language( 'en-uk' )
    xml.pubDate( @step_work_packageable_things.first.event_date.rfc822 ) unless @step_work_packageable_things.empty?
    xml.tag!( 'atom:link', { :href => step_work_packageable_thing_list_url( :format => 'rss' ), :rel => 'self', :type => 'application/rss+xml' } )
    xml << render(:partial => 'work_packageable_thing', :collection => @step_work_packageable_things ) unless @step_work_packageable_things.empty?
  end
end