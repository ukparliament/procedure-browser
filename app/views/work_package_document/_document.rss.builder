xml.item do
	xml.guid( document.link )
	xml.title( business_item_step_label( document ) )
	xml.link( document.link )
	xml.pubDate( document.date.rfc822 ) unless document.date.nil?
end