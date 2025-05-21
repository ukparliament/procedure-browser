module OrganisationAccountableToParliamentWorkPackageHelper

  def organisation_accountable_to_parliament_work_package_results_per_page_link( number, results_per_page )
    organisation_accountable_to_parliament_work_package_results_per_page_link = ''
    if number == results_per_page
      organisation_accountable_to_parliament_work_package_results_per_page_link += number.to_s
    else
      link_to( number.to_s, organisation_accountable_to_parliament_work_package_list_url( 'results-per-page' => number ) )
    end
  end
  
  # A method to display result numbers above the pagination widget.
  def organisation_accountable_to_parliament_work_package_list_pagination_result_numbers( page, results_per_page, result_count )
  
    # We set the from number, being the highest number on the previous page plus one.
    organisation_accountable_to_parliament_work_package_list_pagination_result_numbers = ( ( page - 1 ) * results_per_page + 1 ).to_s
    
    # We add the separator.
    organisation_accountable_to_parliament_work_package_list_pagination_result_numbers += ' - '
    
    # If the highest number possible on this page exceeds the total result count ...
    if ( page * results_per_page ) > result_count
    
      # ... we set the to number, being the total result count.
      organisation_accountable_to_parliament_work_package_list_pagination_result_numbers += result_count.to_s
      
    # Otherwise, if the highest number possible on this page does not exceed the total result count.
    else
    
      # ... we set the to number, being the highest number possible on this page.
      organisation_accountable_to_parliament_work_package_list_pagination_result_numbers += ( page * results_per_page ).to_s
    end
    organisation_accountable_to_parliament_work_package_list_pagination_result_numbers
  end
  
  # A method to generate the previous page link, if any.
  def organisation_accountable_to_parliament_work_package_list_pagination_previous_link( page, results_per_page )
    previous_link = ''
    
    # If this is the second page ...
    if page == 2
    
      # ... if results per page is set to the default ...
      if results_per_page == $DEFAULT_RESULTS_PER_PAGE
      
        # ... we link to the list page with no parameters, because we do not want to expose ?page=1 in the URL.
        previous_link += organisation_accountable_to_parliament_work_package_list_url
        
      # Otherwise, if results per page is not set to the default ... 
      else
      
        # ... we link to the list page with just the results per page parameter, because we do not want to expose ?page=1 in the URL.
        previous_link += organisation_accountable_to_parliament_work_package_list_url( 'results-per-page' => results_per_page )
      end
      
    # Otherwise, if this is the third page or above ...
    elsif page >= 3
    
      # ... if results per page is set to the default ...
      if results_per_page == $DEFAULT_RESULTS_PER_PAGE
      
        # ... we link to the preceding page of the list.
        previous_link += organisation_accountable_to_parliament_work_package_list_url( 'page' => page - 1 )
        
      # Otherwise, if results per page is not set to the default ...
      else
      
        # ... we link to the preceding page of the list with the results per page parameter.
        previous_link += organisation_accountable_to_parliament_work_package_list_url( 'page' => page - 1, 'results-per-page' => results_per_page )
      end
    end
    
    # Otherwise, if this is the first page, there is no link.
    previous_link
  end
  
  # A method to generate the next page link, if any.
  def organisation_accountable_to_parliament_work_package_list_pagination_next_link( page, results_per_page, result_count )
    next_link = ''
    
    # If the list has a subsequent page ...
    if organisation_accountable_to_parliament_work_package_list_pagination_has_subsequent_page( page, results_per_page, result_count )
    
      # ... if results per page is set to the default ...
      if results_per_page == $DEFAULT_RESULTS_PER_PAGE
      
        # ... we link to the next page.
        next_link += organisation_accountable_to_parliament_work_package_list_url( 'page' => page + 1 )
        
      # Otherwise, if results per page is not set to the default ...
      else
      
        # ... we link to the next page with the result per page parameter.
        next_link += organisation_accountable_to_parliament_work_package_list_url( 'page' => page + 1, 'results-per-page' => results_per_page )
      end
    end
    next_link
  end
  
  # A method to determine if there is a next page.
  def organisation_accountable_to_parliament_work_package_list_pagination_has_subsequent_page( page, results_per_page, result_count )
    organisation_accountable_to_parliament_work_package_list_pagination_has_subsequent_page = false
    
    # If the total number of results exceeds the number allowed by this page ...
    if result_count > ( page * results_per_page )
    
      # ... we set the has subsequent page variable to true.
      organisation_accountable_to_parliament_work_package_list_pagination_has_subsequent_page = true
    end
    organisation_accountable_to_parliament_work_package_list_pagination_has_subsequent_page
  end
end