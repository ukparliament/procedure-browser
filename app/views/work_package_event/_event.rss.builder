xml.item do
	xml.guid( event_show_url( :event => event.first.id ) )
	xml.title do
		event.each do |step|
			xml.text!( event_step_label( step ) )
			xml.text!( ' | ' ) unless step == event.last
		end
  	 end
	 xml.description do
		xml.text!( "An event taking place on #{event.first.date.strftime( $DATE_DISPLAY_FORMAT )} as part of a work package focussed on the #{event.first.work_packageable_thing_label}." )
	end
	xml.link( event_show_url( :event => event.first.id ) )
	xml.pubDate( event.first.date.rfc822 )
end