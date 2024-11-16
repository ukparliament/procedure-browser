module Timeline::Timeline

  # A method to get pertinent events of a type.
  def get_pertinent_events_of_type( work_package_events, type )

    # We create an array to hold pertinent events.
    pertinent_events = []
  
    # For each item in the work package events array ...
    work_package_events.each do |event|
  
      # We check the type ...
      case type
    
        # ... and when the type is 'past' events ...
        when 'past'
    
          # ... if the event has a date and the date is today or earlier ...
          if ( event.date ) && ( event.date <= Date.today )
      
            # ... we add the event to the array of pertinent events.
            pertinent_events << event
          end
    
        # Otherwise, if the type is 'future' events ...
        when 'future'
      
          # ... if the event has a date and the date is later than today ...
          if ( event.date ) && ( event.date > Date.today )
    
            # ... we add the event to the array of pertinent events.
            pertinent_events << event
          end
          
        # Otherwise, if the type is 'undated' events ...
        when 'undated'
    
          # ... if the event has no date ...
          unless event.date
    
            # ... we add the event to the array of pertinent events.
            pertinent_events << event
          end
      end
    end
  
    # We return the pertinent events array.
    pertinent_events
  end

  # A method to construct event arrays for a work package.
  def construct_events_array_for_work_package( pertinent_events )

    # We create an array to hold dates for a event list view of a work package.
    dates = []
  
    # For each pertinent event ...
    pertinent_events.each_with_index do |pertinent_event, index|
  
      # ... if this is the first pertinent event ...
      if index == 0
    
        # ... we know it's a new step for a new event on a new date.
        # We create a new array of steps inside a new array of events and add the events array to the dates array.
        dates << Array[Array[pertinent_event]]
      
      # Otherwise, if this is not the first pertinent event ...
      else
      
        # ... if this event has a different date to the preceding event ...
        if pertinent_event.date != pertinent_events[index - 1].date
    
          # ... we know it's a new step for a new event on a new date.
          # We create a new array of steps inside a new array of events and add the events array to the dates array.
          dates << Array[Array[pertinent_event]]
        
        # Otherwise, if this event has the same date as the preceding event ...
        else
        
          # ... if this event has a different identifier to the preceding event ...
          if pertinent_event.identifier != pertinent_events[index - 1].identifier
        
            # ... we know it's a new step for a new event on an existing date.
            # We create a new array of events containing the new step and add it to the last date.
            dates.last << Array[pertinent_event]
          
          # Otherwise, if this event has the same identifier as the preceding event ...
          else
        
            # ... we know this is a new step for an existing event on an existing date.
            # We add the event to the last event array of the last date.
            dates.last.last << pertinent_event
          end
        end
      end
    
    end
  
    # We return the array of events for a work package.
    dates
  end
end