module Timeline::Timeline

  # A method to get pertinent business items of a type.
  def get_pertinent_business_items_of_type( work_package_business_items, type )

    # We create an array to hold pertinent business items.
    pertinent_business_items = []
  
    # For each item in the work package business items array ...
    work_package_business_items.each do |business_item|
  
      # We check the type ...
      case type
    
        # ... and when the type is 'past' business items ...
        when 'past'
    
          # ... if the business item has a date and the date is today or earlier ...
          if ( business_item.date ) && ( business_item.date <= Date.today )
      
            # ... we add the business item to the array of pertinent business items.
            pertinent_business_items << business_item
          end
    
        # Otherwise, if the type is 'future' business items ...
        when 'future'
      
          # ... if the business item has a date and the date is later than today ...
          if ( business_item.date ) && ( business_item.date > Date.today )
    
            # ... we add the business item to the array of pertinent business items.
            pertinent_business_items << business_item
          end
          
        # Otherwise, if the type is 'undated' business items ...
        when 'undated'
    
          # ... if the  business item has no date ...
          unless business_item.date
    
            # ... we add the business item to the array of pertinent business items.
            pertinent_business_items << business_item
          end
      end
    end
  
    # We return the pertinent business items array.
    pertinent_business_items
  end

  # A method to construct business item arrays for a work package.
  def construct_business_items_array_for_work_package( pertinent_business_items )

    # We create an array to hold dates for a business item list view of a work package.
    dates = []
  
    # For each pertinent business item ...
    pertinent_business_items.each_with_index do |pertinent_business_item, index|
  
      # ... if this is the first pertinent business item ...
      if index == 0
    
        # ... we know it's a new step for a new business item on a new date.
        # We create a new array of steps inside a new array of business items and add the business items array to the dates array.
        dates << Array[Array[pertinent_business_item]]
      
      # Otherwise, if this is not the first pertinent business item ...
      else
      
        # ... if this business item has a different date to the preceding business item ...
        if pertinent_business_item.date != pertinent_business_items[index - 1].date
    
          # ... we know it's a new step for a new business item on a new date.
          # We create a new array of steps inside a new array of business items and add the business items array to the dates array.
          dates << Array[Array[pertinent_business_item]]
        
        # Otherwise, if this business item has the same date as the preceding business item ...
        else
        
          # ... if this business item has a different identifier to the preceding business item ...
          if pertinent_business_item.identifier != pertinent_business_items[index - 1].identifier
        
            # ... we know it's a new step for a new business item on an existing date.
            # We create a new array of business items containing the new step and add it to the last date.
            dates.last << Array[pertinent_business_item]
          
          # Otherwise, if this business item has the same identifier as the preceding business item ...
          else
        
            # ... we know this is a new step for an existing business item on an existing date.
            # We add the step to the last business item array of the last date.
            dates.last.last << pertinent_business_item
          end
        end
      end
    
    end
  
    # We return the array of dates for a work package.
    dates
  end
  
  # A method to get a count of business items from an array of actualisations.
  def get_business_item_count( actualisations )
  
    # We set the business item count to zero.
    business_item_count = 0
    
    # For each actualisation ...
    actualisations.each_with_index do |actualisation, index|
    
      # ... if this is the first actualisation ...
      if index == 0
      
        # ... we add one to the business item count.
        business_item_count += 1
        
      # Otherwise, if this is not the first actualisation ...
      else
      
        # ... if this actualisation has a different identifier to the preceding actualisation ...
        if actualisation.identifier != actualisations[index - 1].identifier
      
          # ... we add one to the business item count.
          business_item_count += 1
        end
      end
    end
    
    # We return the business item count.
    business_item_count
  end
end