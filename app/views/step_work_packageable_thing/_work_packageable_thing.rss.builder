xml.item do
  xml.guid( work_packageable_thing_show_url( :work_packageable_thing => work_packageable_thing.id ) )
  xml.title( work_packageable_thing.label )
  xml.link( work_packageable_thing_show_url( :work_packageable_thing => work_packageable_thing.id ) )
  xml.pubDate( work_packageable_thing.event_date.rfc822 )
end