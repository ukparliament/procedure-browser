xml.item do
  xml.guid( work_package_show_url( :work_package => event.work_package_id, :anchor => "event-#{event.id}-actualising-#{step.id}" ) )

  xml.title( event.work_packageable_thing_label )
  xml.link( work_package_show_url( :work_package => event.work_package_id, :anchor => "event-#{event.id}-actualising-#{step.id}" ) )
  xml.pubDate( event.date.rfc822 )
end