xml.item do
  xml.guid( work_package_show_url( :work_package => work_package.id ) )
  xml.title( work_package.work_packageable_thing_label )
  xml.description( work_package_description( work_package ) )
  xml.link( work_package_show_url( :work_package => work_package.id ) )
  xml.pubDate( work_package.made_available_on.rfc822 ) if work_package.made_available_on
end