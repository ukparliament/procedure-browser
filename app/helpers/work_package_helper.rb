module WorkPackageHelper
  
  # A method to generate the previous page link, if any.
  def work_package_list_pagination_previous_link( page, results_per_page )
    previous_link = ''
    
    # If this is the second page ...
    if page == 2
    
      # ... if results per page is set to the default ...
      if results_per_page == $DEFAULT_RESULTS_PER_PAGE
      
        # ... we link to the list page with no parameters, because we do not want to expose ?page=1 in the URL.
        previous_link += work_package_list_url
        
      # Otherwise, if results per page is not set to the default ... 
      else
      
        # ... we link to the list page with just the results per page parameter, because we do not want to expose ?page=1 in the URL.
        previous_link += work_package_list_url( 'results-per-page' => results_per_page )
      end
      
    # Otherwise, if this is the third page or above ...
    elsif page >= 3
    
      # ... if results per page is set to the default ...
      if results_per_page == $DEFAULT_RESULTS_PER_PAGE
      
        # ... we link to the preceding page of the list.
        previous_link += work_package_list_url( 'page' => page - 1 )
        
      # Otherwise, if results per page is not set to the default ...
      else
      
        # ... we link to the preceding page of the list with the results per page parameter.
        previous_link += work_package_list_url( 'page' => page - 1, 'results-per-page' => results_per_page )
      end
    end
    
    # Otherwise, if this is the first page, there is no link.
    previous_link
  end
  
  # A method to generate the next page link, if any.
  def work_package_list_pagination_next_link( page, results_per_page, result_count )
    next_link = ''
    
    # If the list has a subsequent page ...
    if pagination_has_subsequent_page( page, results_per_page, result_count )
    
      # ... if results per page is set to the default ...
      if results_per_page == $DEFAULT_RESULTS_PER_PAGE
      
        # ... we link to the next page.
        next_link += work_package_list_url( 'page' => page + 1 )
        
      # Otherwise, if results per page is not set to the default 
      else
      
        # ... we link to the next page with the result per page parameter.
        next_link += work_package_list_url( 'page' => page + 1, 'results-per-page' => results_per_page )
      end
    end
    next_link
  end
  
  def work_package_results_per_page_link( number, results_per_page )
    work_package_results_per_page_link = ''
    if number == results_per_page
      work_package_results_per_page_link += number.to_s
    else
      link_to( number.to_s, work_package_list_url( 'results-per-page' => number ) )
    end
  end
  
  def work_package_description_with_markup( work_package )
    work_package_list_item_description = 'A work package'
    if work_package.made_available_on
      work_package_list_item_description += ', made available on '
      work_package_list_item_description += work_package.made_available_on.strftime( $DATE_DISPLAY_FORMAT )
    end
    work_package_list_item_description += ', subject to the '
    work_package_list_item_description += link_to( work_package.procedure_label, procedure_show_url( :procedure => work_package.procedure_id ) )
    work_package_list_item_description += ' procedure.'
    unless work_package.calculation_style_identifier.blank?
      work_package_list_item_description += ' Scrutiny period described by '
      work_package_list_item_description += link_to( work_package.calculation_style_label, calculation_style_show_url( :calculation_style => work_package.calculation_style_id ) )
      work_package_list_item_description += '.'
    end
    work_package_list_item_description = work_package_list_item_description.html_safe
    content_tag( 'p', work_package_list_item_description )
  end
  
  def work_package_description_with_markup_from_business_item( business_item )
    work_package_list_item_description = "A #{link_to( 'work package', work_package_show_url( :work_package => business_item.work_package_id ) )} focussed on the "
    work_package_list_item_description += link_to( business_item.work_packageable_thing_label, work_packageable_thing_show_url( :work_packageable_thing => business_item.work_packageable_thing_id ) )
    if business_item.work_package_made_available_on
      work_package_list_item_description += ', made available on '
      work_package_list_item_description += business_item.work_package_made_available_on.strftime( $DATE_DISPLAY_FORMAT )
      work_package_list_item_description += ', subject to the '
    else
      work_package_list_item_description += ', subject to the '
    end
    work_package_list_item_description += link_to( business_item.procedure_label, procedure_show_url( :procedure => business_item.procedure_id ) )
    work_package_list_item_description += ' procedure.'
    unless business_item.calculation_style_identifier.blank?
      work_package_list_item_description += ' Scrutiny period described by '
      work_package_list_item_description += link_to( business_item.calculation_style_label, calculation_style_show_url( :calculation_style => business_item.calculation_style_id ) )
      work_package_list_item_description += '.'
    end
    work_package_list_item_description = work_package_list_item_description.html_safe
    content_tag( 'p', work_package_list_item_description )
  end
  
  def work_package_description_with_work_packageable_thing_and_markup( work_package )
    work_package_list_item_description = 'A work package focussed on the '
    work_package_list_item_description += link_to( work_package.work_packageable_thing_label, work_packageable_thing_show_url( :work_packageable_thing => work_package.work_packageable_thing_id ) )
    if work_package.made_available_on
      work_package_list_item_description += ', made available on '
      work_package_list_item_description += work_package.made_available_on.strftime( $DATE_DISPLAY_FORMAT )
      work_package_list_item_description += ', subject to the '
    else
      work_package_list_item_description += ', subject to the '
    end
    work_package_list_item_description += link_to( work_package.procedure_label, procedure_show_url( :procedure => work_package.procedure_id ) )
    work_package_list_item_description += ' procedure.'
    unless work_package.calculation_style_identifier.blank?
      work_package_list_item_description += ' Scrutiny period described by '
      work_package_list_item_description += link_to( work_package.calculation_style_label, calculation_style_show_url( :calculation_style => work_package.calculation_style_id ) )
      work_package_list_item_description += '.'
    end
    work_package_list_item_description = work_package_list_item_description.html_safe
    content_tag( 'p', work_package_list_item_description )
  end
  
  def work_package_description( work_package )
    work_package_list_item_description = 'Made available on '
    work_package_list_item_description += work_package.made_available_on.strftime( $DATE_DISPLAY_FORMAT )
    work_package_list_item_description += ', subject to the '
    work_package_list_item_description += work_package.procedure_label
    work_package_list_item_description += ' procedure.'
    unless work_package.calculation_style_identifier.blank?
      work_package_list_item_description += ' Scrutiny period described by '
      work_package_list_item_description += work_package.calculation_style_label
      work_package_list_item_description += '.'
    end
    work_package_list_item_description
  end
  
  def work_package_table_of_contents( work_package_past_business_items, work_package_future_business_items, work_package_undated_business_items )
    toc_links = []
    unless work_package_past_business_items.empty?
      link = { :id => 'past', :label => 'Business items which have happened' }
      toc_links << link
    end
    unless work_package_future_business_items.empty?
      link = { :id => 'future', :label => 'Business items due to happen' }
      toc_links << link
    end
    unless work_package_undated_business_items.empty?
      link = { :id => 'undated', :label => 'Business items which do not have a date' }
      toc_links << link
    end
    work_package_table_of_contents = ''
    if toc_links.size > 1
      toc_links.each do |toc_link|
        work_package_table_of_contents += link_to( toc_link[:label], :anchor => toc_link[:id] )
        work_package_table_of_contents += ' - ' if toc_link != toc_links.last
      end
      work_package_table_of_contents = work_package_table_of_contents.html_safe
      content_tag( 'p', work_package_table_of_contents )
    end
  end
end
