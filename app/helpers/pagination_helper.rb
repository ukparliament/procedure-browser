module PaginationHelper

  # A method to display result numbers above the pagination widget.
  def pagination_result_numbers( page, results_per_page, result_count )

    # We set the from number, being the highest number on the previous page plus one.
    pagination_result_numbers = ( ( page - 1 ) * results_per_page + 1 ).to_s
  
    # We add the separator.
    pagination_result_numbers += ' - '
  
    # If the highest number possible on this page exceeds the total result count ...
    if ( page * results_per_page ) > result_count
  
      # ... we set the to number, being the total result count.
      pagination_result_numbers += result_count.to_s
    
    # Otherwise, if the highest number possible on this page does not exceed the total result count.
    else
  
      # ... we set the to number, being the highest number possible on this page.
      pagination_result_numbers += ( page * results_per_page ).to_s
    end
    pagination_result_numbers
  end
  
  # A method to determine if there is a next page.
  def pagination_has_subsequent_page( page, results_per_page, result_count )
    pagination_has_subsequent_page = false
    
    # If the total number of results exceeds the number allowed by this page ...
    if result_count > ( page * results_per_page )
    
      # ... we set the has subsequent page variable to true.
      pagination_has_subsequent_page = true
    end
    pagination_has_subsequent_page
  end
end