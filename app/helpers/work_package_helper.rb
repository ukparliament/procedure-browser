module WorkPackageHelper

  # A method to display result numbers above the pagination widget.
  def work_package_list_pagination_result_numbers( page, results_per_page, result_count )
  
    # We set the from number, being the highest number on the previous page plus one.
    work_package_list_pagination_result_numbers = ( ( page - 1 ) * results_per_page + 1 ).to_s
    
    # We add the separator.
    work_package_list_pagination_result_numbers += ' - '
    
    # If the highest number possible on this page exceeds the total result count ...
    if ( page * results_per_page ) > result_count
    
      # ... we set the to number, being the total result count.
      work_package_list_pagination_result_numbers += result_count.to_s
      
    # Otherwise, if the highest number possible on this page does not exceed the total result count.
    else
    
      # ... we set the to number, being the highest number possible on this page.
      work_package_list_pagination_result_numbers += ( page * results_per_page ).to_s
    end
    work_package_list_pagination_result_numbers
  end
  
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
    if work_package_list_pagination_has_subsequent_page( page, results_per_page, result_count )
    
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
  
  # A method to determine if there is a next page.
  def work_package_list_pagination_has_subsequent_page( page, results_per_page, result_count )
    work_package_list_pagination_has_subsequent_page = false
    
    # If the total number of results exceeds the number allowed by this page ...
    if result_count > ( page * results_per_page )
    
      # ... we set the has subsequent page variable to true.
      work_package_list_pagination_has_subsequent_page = true
    end
    work_package_list_pagination_has_subsequent_page
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
  
  def work_package_table_of_contents( work_package_past_events, work_package_future_events, work_package_undated_events )
    toc_links = []
    unless work_package_past_events.empty?
      link = { :id => 'past-events', :label => 'Events having happened' }
      toc_links << link
    end
    unless work_package_future_events.empty?
      link = { :id => 'future-events', :label => 'Events due to happen' }
      toc_links << link
    end
    unless work_package_future_events.empty?
      link = { :id => 'undated-events', :label => 'Events having no date' }
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
