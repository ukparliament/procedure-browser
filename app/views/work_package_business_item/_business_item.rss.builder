xml.item do
	xml.guid( business_item_show_url( :business_item => business_item.first.id ) )
	xml.title( business_item_rss_title( business_item ) )
	xml.description( "A business item taking place on #{business_item.first.date.strftime( $DATE_DISPLAY_FORMAT )} as part of a work package focussed on the #{business_item.first.work_packageable_thing_label}." )
	xml.link( business_item_show_url( :business_item => business_item.first.id ) )
	xml.pubDate( business_item.first.date.rfc822 ) unless business_item.empty? or business_item.first.date.nil?
end