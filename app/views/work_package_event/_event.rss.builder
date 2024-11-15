xml.item do
	xml.guid( event_show_url( :event => event.first.id ) )
	xml.title( event_rss_title(event) )
	xml.description( "An event taking place on #{event.first.date.strftime( $DATE_DISPLAY_FORMAT )} as part of a work package focussed on the #{event.first.work_packageable_thing_label}." )
	xml.link( event_show_url( :event => event.first.id ) )
	xml.pubDate( event.first.date.rfc822 )
end