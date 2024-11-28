module BusinessItemHelper

  def business_item_step_label( step )
    step_label_in_list = step.step_label
    step_label_in_list += " (#{step_houses_and_legislature_label( step )})" unless step_houses_and_legislature_label( step ).empty?
    step_label_in_list.html_safe
  end

  def business_item_rss_title( business_item )
    business_item_rss_title = ''
    business_item.each do |step|
      business_item_rss_title += business_item_step_label( step )
      business_item_rss_title += ' | ' unless step == business_item.last
    end
    business_item_rss_title
  end
end
