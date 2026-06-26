xml.item do
	xml.guid( business_item.link )
	xml.title( business_item_step_label( business_item ) )
	xml.link( business_item.link )
	xml.pubDate( business_item.date.rfc822 ) unless business_item.date.nil?
end