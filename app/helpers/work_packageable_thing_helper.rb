module WorkPackageableThingHelper

  def work_packageable_thing_results_per_page_link( number, results_per_page )
    work_packageable_thing_results_per_page_link = ''
    if number == results_per_page
      work_packageable_thing_results_per_page_link += number.to_s
    else
      link_to( number.to_s, work_packageable_thing_list_url( 'results-per-page' => number ) )
    end
  end

  def work_packageable_thing_results_per_page_current_link( number, results_per_page )
    work_packageable_thing_results_per_page_current_link = ''
    if number == results_per_page
      work_packageable_thing_results_per_page_current_link += number.to_s
    else
      link_to( number.to_s, work_packageable_thing_current_list_url( 'results-per-page' => number ) )
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
    if pagination_has_subsequent_page( page, results_per_page, result_count )
    
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
  
  # A method to generate the previous page link for a list of current work packageable things, if any.
  def work_packageable_thing_current_list_pagination_previous_link( page, results_per_page )
    previous_link = ''
    
    # If this is the second page ...
    if page == 2
    
      # ... if results per page is set to the default ...
      if results_per_page == $DEFAULT_RESULTS_PER_PAGE
      
        # ... we link to the list page with no parameters, because we do not want to expose ?page=1 in the URL.
        previous_link += work_packageable_thing_current_list_url
        
      # Otherwise, if results per page is not set to the default ... 
      else
      
        # ... we link to the list page with just the results per page parameter, because we do not want to expose ?page=1 in the URL.
        previous_link += work_packageable_thing_current_list_url( 'results-per-page' => results_per_page )
      end
      
    # Otherwise, if this is the third page or above ...
    elsif page >= 3
    
      # ... if results per page is set to the default ...
      if results_per_page == $DEFAULT_RESULTS_PER_PAGE
      
        # ... we link to the preceding page of the list.
        previous_link += work_packageable_thing_current_list_url( 'page' => page - 1 )
        
      # Otherwise, if results per page is not set to the default ...
      else
      
        # ... we link to the preceding page of the list with the results per page parameter.
        previous_link += work_packageable_thing_current_list_url( 'page' => page - 1, 'results-per-page' => results_per_page )
      end
    end
    
    # Otherwise, if this is the first page, there is no link.
    previous_link
  end
  
  # A method to generate the next page link for a list of current work packageable things, if any.
  def work_packageable_thing_current_list_pagination_next_link( page, results_per_page, result_count )
    next_link = ''
    
    # If the list has a subsequent page ...
    if pagination_has_subsequent_page( page, results_per_page, result_count )
    
      # ... if results per page is set to the default ...
      if results_per_page == $DEFAULT_RESULTS_PER_PAGE
      
        # ... we link to the next page.
        next_link += work_packageable_thing_current_list_url( 'page' => page + 1 )
        
      # Otherwise, if results per page is not set to the default 
      else
      
        # ... we link to the next page with the result per page parameter.
        next_link += work_packageable_thing_current_list_url( 'page' => page + 1, 'results-per-page' => results_per_page )
      end
    end
    next_link
  end
  
  # A method to generate the work packageable thing description sentence.
  def work_packageable_thing_description( work_packageable_thing )
    work_packageable_thing_description = ''
    
    # If the work packageable thing has a treaty series citation ...
    if work_packageable_thing.treaty_series_citation
    
      # ... know the work packageable thing is a treaty ...
      # ... so we construct the treaty sentence.
      work_packageable_thing_description += work_packageable_thing.command_paper_prefix
      work_packageable_thing_description += ' '
      work_packageable_thing_description += work_packageable_thing.command_paper_number
      work_packageable_thing_description += ' ('
      work_packageable_thing_description += work_packageable_thing.treaty_series_citation
      work_packageable_thing_description += '), led by the '
      work_packageable_thing_description += link_to(work_packageable_thing.lead_government_organisation_label, organisation_accountable_to_parliament_show_url( :organisation_accountable_to_parliament => work_packageable_thing.lead_government_organisation_id ) )
      work_packageable_thing_description += '.'
      
    # Otherwise, if the work packageageable thing has a lead department ...
    elsif work_packageable_thing.lead_government_organisation_label
    
      # ... know the work packageable thing is a negotiation for a treaty ...
      # ... so we construct the negotiation for a treaty sentence.
      work_packageable_thing_description += 'Led by the '
      work_packageable_thing_description += link_to(work_packageable_thing.lead_government_organisation_label, organisation_accountable_to_parliament_show_url( :organisation_accountable_to_parliament => work_packageable_thing.lead_government_organisation_id ) )
      work_packageable_thing_description += '.'
    else
    
      # TODO: whatever needs to happen with secondary legislation.
    end
    
    # If the work packageable thing description is not empty, we wrap it in a paragraph.
    content_tag( 'p', work_packageable_thing_description ) if !work_packageable_thing_description.empty?
    
    
    # We return the work packageable thing description.
    work_packageable_thing_description.html_safe
  end
end

