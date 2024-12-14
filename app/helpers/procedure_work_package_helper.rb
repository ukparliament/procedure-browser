module ProcedureWorkPackageHelper

  def procedure_work_package_results_per_page_link( number, results_per_page )
    work_package_results_per_page_link = ''
    if number == results_per_page
      work_package_results_per_page_link += number.to_s
    else
      link_to( number.to_s, procedure_work_package_list_url( 'results-per-page' => number ) )
    end
  end
  
  def procedure_work_package_description_with_markup( work_package )
    work_package_list_item_description = 'A work package focussed on the '
    work_package_list_item_description += link_to( work_package.work_packageable_thing_label, work_packageable_thing_show_url( :work_packageable_thing => work_package.work_packageable_thing_id ) )
    if work_package.made_available_on
      work_package_list_item_description += ', made available on '
      work_package_list_item_description += work_package.made_available_on.strftime( $DATE_DISPLAY_FORMAT )
    end
    work_package_list_item_description += '.'
    work_package_list_item_description = work_package_list_item_description.html_safe
    content_tag( 'p', work_package_list_item_description )
  end
  
  # A method to generate the previous page link, if any.
  def procedure_work_package_list_pagination_previous_link( page, results_per_page )
    previous_link = ''
    
    # If this is the second page ...
    if page == 2
    
      # ... if results per page is set to the default ...
      if results_per_page == $DEFAULT_RESULTS_PER_PAGE
      
        # ... we link to the list page with no parameters, because we do not want to expose ?page=1 in the URL.
        previous_link += procedure_work_package_list_url
        
      # Otherwise, if results per page is not set to the default ... 
      else
      
        # ... we link to the list page with just the results per page parameter, because we do not want to expose ?page=1 in the URL.
        previous_link += procedure_work_package_list_url( 'results-per-page' => results_per_page )
      end
      
    # Otherwise, if this is the third page or above ...
    elsif page >= 3
    
      # ... if results per page is set to the default ...
      if results_per_page == $DEFAULT_RESULTS_PER_PAGE
      
        # ... we link to the preceding page of the list.
        previous_link += procedure_work_package_list_url( 'page' => page - 1 )
        
      # Otherwise, if results per page is not set to the default ...
      else
      
        # ... we link to the preceding page of the list with the results per page parameter.
        previous_link += procedure_work_package_list_url( 'page' => page - 1, 'results-per-page' => results_per_page )
      end
    end
    
    # Otherwise, if this is the first page, there is no link.
    previous_link
  end
  
  # A method to generate the next page link, if any.
  def procedure_work_package_list_pagination_next_link( page, results_per_page, result_count )
    next_link = ''
    
    # If the list has a subsequent page ...
    if work_package_list_pagination_has_subsequent_page( page, results_per_page, result_count )
    
      # ... if results per page is set to the default ...
      if results_per_page == $DEFAULT_RESULTS_PER_PAGE
      
        # ... we link to the next page.
        next_link += procedure_work_package_list_url( 'page' => page + 1 )
        
      # Otherwise, if results per page is not set to the default ...
      else
      
        # ... we link to the next page with the result per page parameter.
        next_link += procedure_work_package_list_url( 'page' => page + 1, 'results-per-page' => results_per_page )
      end
    end
    next_link
  end 
end
