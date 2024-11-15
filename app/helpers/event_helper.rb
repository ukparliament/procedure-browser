module EventHelper

  def event_rss_title( event )
    event_rss_title = ''
    event.each do |step|
      event_rss_title += event_step_label( step )
      event_rss_title += ' | ' unless step == event.last
    end
    event_rss_title
  end
end
