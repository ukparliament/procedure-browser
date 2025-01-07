module RouteChecker::RouteChecker

  # ## A method to check the number of inbound and outbound routes for a step.
  def check_inbound_and_outbound_routes_to_step( step, routes )

    # We get the inbound routes.
    inbound_routes =  routes.select { |route| route.to_step_identifier == step.identifier }

    # We get the outbound routes.
    outbound_routes =  routes.select { |route| route.from_step_identifier == step.identifier }

    # We check the number of inbound routes and outbound routes for the step, according to its type.
    check_routes_for_step_by_type( inbound_routes, outbound_routes, step )
  end

  # ## A method to check the number of inbound routes and outbounds routes for a step, according to its type.
  # Based on [logic for validating the number of inbound and outbound routes for a step of a given type](https://ukparliament.github.io/ontologies/procedure/maps/meta/design-notes/#validating-inputs-and-outputs-to-steps).
  def check_routes_for_step_by_type( inbound_routes, outbound_routes, step )
  
    # We check the step label.
    case step.step_type_label

      # If the step type label is 'Business step' ...
      when 'Business step'
      
        # A business step has one inbound route.
        # Unless the business step has one inbound route ...
        unless inbound_routes.size == 1
        
          # ... we report an incorrect number of inbound routes.
          report_incorrect_number_of_inbound_routes( inbound_routes, step, 1 )
        end
      
        # A business step has zero, one or many outbound routes ...
        # ... so we don't check.

      # If the step type label is 'Decision', 'NOT' or 'INCREMENT' ...
      when 'Decision', 'NOT', 'INCREMENT'
    
        # Decision, NOT and INCREMENT steps have one inbound route.
        # Unless the step has one inbound route ...
        unless inbound_routes.size == 1
      
          # ... we report an incorrect number of inbound routes.
          report_incorrect_number_of_inbound_routes( inbound_routes, step, 1 )
        end
    
        # Decision, NOT and INCREMENT steps have one outbound route.
        # Unless the step has one outbound route ...
        unless outbound_routes.size == 1
      
          # ... we report an incorrect number of outbound routes.
          report_incorrect_number_of_outbound_routes( outbound_routes, step, 1 )
        end
      
      # If the step type label is 'AND', 'OR', 'SUM' or 'EQUALS' ...
      when 'AND', 'OR', 'SUM', 'EQUALS'
      
        # AND, OR, SUM and EQUALS step have two inbound routes.
        # Unless the step has two inbound routes ...
        unless inbound_routes.size == 2
  
          # ... we report an incorrect number of inbound routes.
          report_incorrect_number_of_inbound_routes( inbound_routes, step, 2 )
        end

        # AND, OR, SUM and EQUALS step have one outbound route.
        # Unless the step has one outbound route ...
        unless outbound_routes.size == 1
  
          # ... we report an incorrect number of outbound routes.
          report_incorrect_number_of_outbound_routes( outbound_routes, step, 1 )
        end
      
      # If the step type label is 'Summation' ...
      when 'Summation'
      
        # Summation step have one inbound route.
        # Unless the step has one inbound route ...
        unless inbound_routes.size == 1
  
          # ... we report an incorrect number of inbound routes.
          report_incorrect_number_of_inbound_routes( inbound_routes, step, 1 )
        end

        # Summation step have one or more outbound routes.
        # Unless the step has one or more outbound routes ...
        unless outbound_routes.size >= 1
  
          # ... we report an incorrect number of outbound routes.
          report_incorrect_number_of_outbound_routes( outbound_routes, step, '1 or more' )
        end
      end
  end

  # ## A method to report an incorrect number of inbound routes.
  def report_incorrect_number_of_inbound_routes( inbound_routes, step, expected_inbound_route_count )

    # We create a symbol to hold the parts of the error message.
    error_message = {}
  
    # We give the error message a title.
    error_message[:title] = "#{step.display_label} has #{inbound_routes.size} inbound #{'route'.pluralize( inbound_routes.size )}."
  
    # We give the error message some clarification text.
    error_message[:clarification] = "#{expected_inbound_route_count} inbound #{'route'.pluralize( expected_inbound_route_count )} #{'was'.pluralize( expected_inbound_route_count )} expected."
  
    # We give the error message a title for the route listing.
    error_message[:routes_listing_title] = "Inbound #{'route'.pluralize( inbound_routes.size )} present from:"
  
    # We create an array to hold the labels of source steps of inbound routes.
    steps = []
  
    # For each inbound route ...
    inbound_routes.each do |inbound_route|
  
      # ... we add the full label of the source step to the array.
      steps << inbound_route.from_step_full_label
    end
  
    # We add the array of source step labels to the error message.
    error_message[:steps] = steps
  
    # We add the error message to the array of all error messages.
    @inbound_and_outbound_route_errors << error_message
  end

  # ## A method to report an incorrect number of outbound routes.
  def report_incorrect_number_of_outbound_routes( outbound_routes, step, expected_outbound_route_count )

    # We create a symbol to hold the parts of the error message.
    error_message = {}
  
    # We give the error message a title.
    error_message[:title] = "#{step.display_label} has #{outbound_routes.size} outbound #{'route'.pluralize( outbound_routes.size )}."
  
    # We give the error message some clarification text.
    error_message[:clarification] = "#{expected_outbound_route_count} outbound #{'route'.pluralize( expected_outbound_route_count )} #{'was'.pluralize( expected_outbound_route_count )} expected."
  
    # We give the error message a title for the route listing.
    error_message[:routes_listing_title] = "Outbound #{'route'.pluralize( outbound_routes.size )} present from:"
  
    # We create an array to hold the labels of source steps of inbound routes.
    steps = []
  
    # For each outbound route ...
    outbound_routes.each do |outbound_route|
  
      # ... we add the full label of the destination step to the array.
      steps << outbound_route.to_step_full_label
    end
  
    # We add the array of destination step labels to the error message.
    error_message[:steps] = steps
  
    # We add the error message to the array of all error messages.
    @inbound_and_outbound_route_errors << error_message
  end
end