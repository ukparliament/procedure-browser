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
end