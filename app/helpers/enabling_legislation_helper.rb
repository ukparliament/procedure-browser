module EnablingLegislationHelper

  def enabling_legislation_description_with_markup( enabling_legislation )
    enabling_legislation_description_with_markup = ''
    enabling_legislation_description_with_markup += enabling_legislation.year
    enabling_legislation_description_with_markup += ' c. '
    enabling_legislation_description_with_markup += enabling_legislation.act_number
    enabling_legislation_description_with_markup += '. An Act of Parliament gaining Royal Assent on '
    enabling_legislation_description_with_markup += enabling_legislation.date.strftime( $DATE_DISPLAY_FORMAT )
    enabling_legislation_description_with_markup += '.'
  end

  def enabling_legislation_description( enabling_legislation )
    enabling_legislation_description = ''
    enabling_legislation_description += enabling_legislation.year
    enabling_legislation_description += ' c. '
    enabling_legislation_description += enabling_legislation.act_number
    enabling_legislation_description += '. An Act of Parliament gaining Royal Assent on '
    enabling_legislation_description += enabling_legislation.date.strftime( $DATE_DISPLAY_FORMAT )
    enabling_legislation_description += '.'
  end

  def enabling_legislation_results_per_page_link( number, results_per_page )
    enabling_legislation_results_per_page_link = ''
    if number == results_per_page
      enabling_legislation_results_per_page_link += number.to_s
    else
      link_to( number.to_s, enabling_legislation_list_url( 'results-per-page' => number ) )
    end
  end
  
  # A method to display result numbers above the pagination widget.
  def enabling_legislation_list_pagination_result_numbers( page, results_per_page, result_count )
  
    # We set the from number, being the highest number on the previous page plus one.
    enabling_legislation_list_pagination_result_numbers = ( ( page - 1 ) * results_per_page + 1 ).to_s
    
    # We add the separator.
    enabling_legislation_list_pagination_result_numbers += ' - '
    
    # If the highest number possible on this page exceeds the total result count ...
    if ( page * results_per_page ) > result_count
    
      # ... we set the to number, being the total result count.
      enabling_legislation_list_pagination_result_numbers += result_count.to_s
      
    # Otherwise, if the highest number possible on this page does not exceed the total result count.
    else
    
      # ... we set the to number, being the highest number possible on this page.
      enabling_legislation_list_pagination_result_numbers += ( page * results_per_page ).to_s
    end
    enabling_legislation_list_pagination_result_numbers
  end
  
  # A method to generate the previous page link, if any.
  def enabling_legislation_list_pagination_previous_link( page, results_per_page )
    previous_link = ''
    
    # If this is the second page ...
    if page == 2
    
      # ... if results per page is set to the default ...
      if results_per_page == $DEFAULT_RESULTS_PER_PAGE
      
        # ... we link to the list page with no parameters, because we do not want to expose ?page=1 in the URL.
        previous_link += enabling_legislation_list_url
        
      # Otherwise, if results per page is not set to the default ... 
      else
      
        # ... we link to the list page with just the results per page parameter, because we do not want to expose ?page=1 in the URL.
        previous_link += enabling_legislation_list_url( 'results-per-page' => results_per_page )
      end
      
    # Otherwise, if this is the third page or above ...
    elsif page >= 3
    
      # ... if results per page is set to the default ...
      if results_per_page == $DEFAULT_RESULTS_PER_PAGE
      
        # ... we link to the preceding page of the list.
        previous_link += enabling_legislation_list_url( 'page' => page - 1 )
        
      # Otherwise, if results per page is not set to the default ...
      else
      
        # ... we link to the preceding page of the list with the results per page parameter.
        previous_link += enabling_legislation_list_url( 'page' => page - 1, 'results-per-page' => results_per_page )
      end
    end
    
    # Otherwise, if this is the first page, there is no link.
    previous_link
  end
  
  # A method to generate the next page link, if any.
  def enabling_legislation_list_pagination_next_link( page, results_per_page, result_count )
    next_link = ''
    
    # If the list has a subsequent page ...
    if enabling_legislation_list_pagination_has_subsequent_page( page, results_per_page, result_count )
    
      # ... if results per page is set to the default ...
      if results_per_page == $DEFAULT_RESULTS_PER_PAGE
      
        # ... we link to the next page.
        next_link += enabling_legislation_list_url( 'page' => page + 1 )
        
      # Otherwise, if results per page is not set to the default ...
      else
      
        # ... we link to the next page with the result per page parameter.
        next_link += enabling_legislation_list_url( 'page' => page + 1, 'results-per-page' => results_per_page )
      end
    end
    next_link
  end
  
  # A method to determine if there is a next page.
  def enabling_legislation_list_pagination_has_subsequent_page( page, results_per_page, result_count )
    enabling_legislation_list_pagination_has_subsequent_page = false
    
    # If the total number of results exceeds the number allowed by this page ...
    if result_count > ( page * results_per_page )
    
      # ... we set the has subsequent page variable to true.
      enabling_legislation_list_pagination_has_subsequent_page = true
    end
    enabling_legislation_list_pagination_has_subsequent_page
  end
end
