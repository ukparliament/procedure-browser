xml.item do
  xml.guid( work_package_show_url( :work_package => business_item.work_package_id, :anchor => "business-item-#{business_item.id}-actualising-#{business_item.step_id}" ) )
  xml.title( business_item.work_packageable_thing_label )
  xml.link( work_package_show_url( :work_package => business_item.work_package_id, :anchor => "business-item-#{business_item.id}-actualising-#{business_item.step_id}" ) )
  xml.pubDate( business_item.date.rfc822 )
end