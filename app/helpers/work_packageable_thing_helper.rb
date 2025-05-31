module WorkPackageableThingHelper

  def work_packageable_thing_results_per_page_link( number, results_per_page )
    work_packageable_thing_results_per_page_link = ''
    if number == results_per_page
      work_packageable_thing_results_per_page_link += number.to_s
    else
      link_to( number.to_s, work_packageable_thing_list_url( 'results-per-page' => number ) )
    end
  end
  
  # A method to generate the previous page link, if any.
  def work_packageable_thing_list_pagination_previous_link( page, results_per_page )
    previous_link = ''
    
    # If this is the second page ...
    if page == 2
    
      # ... if results per page is set to the default ...
      if results_per_page == $DEFAULT_RESULTS_PER_PAGE
      
        # ... we link to the list page with no parameters, because we do not want to expose ?page=1 in the URL.
        previous_link += work_packageable_thing_list_url
        
      # Otherwise, if results per page is not set to the default ... 
      else
      
        # ... we link to the list page with just the results per page parameter, because we do not want to expose ?page=1 in the URL.
        previous_link += work_packageable_thing_list_url( 'results-per-page' => results_per_page )
      end
      
    # Otherwise, if this is the third page or above ...
    elsif page >= 3
    
      # ... if results per page is set to the default ...
      if results_per_page == $DEFAULT_RESULTS_PER_PAGE
      
        # ... we link to the preceding page of the list.
        previous_link += work_packageable_thing_list_url( 'page' => page - 1 )
        
      # Otherwise, if results per page is not set to the default ...
      else
      
        # ... we link to the preceding page of the list with the results per page parameter.
        previous_link += work_packageable_thing_list_url( 'page' => page - 1, 'results-per-page' => results_per_page )
      end
    end
    
    # Otherwise, if this is the first page, there is no link.
    previous_link
  end
  
  # A method to generate the next page link, if any.
  def work_packageable_thing_list_pagination_next_link( page, results_per_page, result_count )
    next_link = ''
    
    # If the list has a subsequent page ...
    if work_packageable_thing_list_pagination_has_subsequent_page( page, results_per_page, result_count )
    
      # ... if results per page is set to the default ...
      if results_per_page == $DEFAULT_RESULTS_PER_PAGE
      
        # ... we link to the next page.
        next_link += work_packageable_thing_list_url( 'page' => page + 1 )
        
      # Otherwise, if results per page is not set to the default 
      else
      
        # ... we link to the next page with the result per page parameter.
        next_link += work_packageable_thing_list_url( 'page' => page + 1, 'results-per-page' => results_per_page )
      end
    end
    next_link
  end
  
  # A method to determine if there is a next page.
  def work_packageable_thing_list_pagination_has_subsequent_page( page, results_per_page, result_count )
    work_packageable_thing_list_pagination_has_subsequent_page = false
    
    # If the total number of results exceeds the number allowed by this page ...
    if result_count > ( page * results_per_page )
    
      # ... we set the has subsequent page variable to true.
      work_packageable_thing_list_pagination_has_subsequent_page = true
    end
    work_packageable_thing_list_pagination_has_subsequent_page
  end
end

