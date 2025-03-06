xml.item do
  xml.guid( enabling_legislation_show_url( :enabling_legislation => enabling_legislation.id ) )
  xml.title( enabling_legislation.label )
  xml.description( enabling_legislation_description( enabling_legislation ) )
  xml.link( enabling_legislation_show_url( :enabling_legislation => enabling_legislation.id ) )
  xml.pubDate( enabling_legislation.date.rfc822 )
end