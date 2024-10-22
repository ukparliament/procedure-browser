module StepRouteHelper

  def route_title( route )
    route_title = 'A '
    route_title += link_to( 'Route', route_show_url( :route => route.id ) )
    route_title += ' from '
    route_title += route_from_step_label( route )
    route_title += ' to '
    route_title += route_to_step_label( route )
    route_title += ' as part of the '
    route_title += link_to( route.procedure_label, procedure_show_url( :procedure => route.procedure_id ) )
    route_title += ' procedure'
    route_title.html_safe
  end
  
  def route_from_step_label( route )
    route_from_step_label = route.from_step_label
    route_from_step_label += " #{route.from_step_type_label}" unless route.from_step_type_id == 'Jwc6nqJi'
    route_from_step_label += " (#{route_from_step_houses_and_legislature_label( route )})" unless route_from_step_houses_and_legislature_label( route ).empty?
    route_from_step_label = link_to( route_from_step_label, step_show_url( :step => route.from_step_id ) )
    route_from_step_label
  end
  
  def route_from_step_houses_and_legislature_label( route )
    houses_and_legislatures = []
    route_from_step_houses_and_legislature_label = ''
    if route.from_step_commons_identifier
      houses_and_legislatures << 'House of Commons'
    end
    if route.from_step_lords_identifier
      houses_and_legislatures << 'House of Lords'
    end
    if route.from_step_legislature_identifier
      houses_and_legislatures << route.from_step_legislature_label
    end
    
    houses_and_legislatures.each do |hl|
      if hl != houses_and_legislatures.first
        if hl != houses_and_legislatures.last
          route_from_step_houses_and_legislature_label += ', '
        else
          route_from_step_houses_and_legislature_label += ' and '
        end
      end
      route_from_step_houses_and_legislature_label += hl
    end
      
    route_from_step_houses_and_legislature_label.html_safe
  end
  
  def route_to_step_label( route )
    route_to_step_label = route.to_step_label
    route_to_step_label += " #{route.to_step_type_label}" unless route.to_step_type_id == 'Jwc6nqJi'
    route_to_step_label += " (#{route_to_step_houses_and_legislature_label( route )})" unless route_to_step_houses_and_legislature_label( route ).empty?
    route_to_step_label = link_to( route_to_step_label, step_show_url( :step => route.to_step_id ) )
    route_to_step_label
  end
  
  def route_to_step_houses_and_legislature_label( route )
    houses_and_legislatures = []
    route_to_step_houses_and_legislature_label = ''
    if route.to_step_commons_identifier
      houses_and_legislatures << 'House of Commons'
    end
    if route.to_step_lords_identifier
      houses_and_legislatures << 'House of Lords'
    end
    if route.to_step_legislature_identifier
      houses_and_legislatures << route.to_step_legislature_label
    end
    
    houses_and_legislatures.each do |hl|
      if hl != houses_and_legislatures.first
        if hl != houses_and_legislatures.last
          route_to_step_houses_and_legislature_label += ', '
        else
          route_to_step_houses_and_legislature_label += ' and '
        end
      end
      route_to_step_houses_and_legislature_label += hl
    end
      
    route_to_step_houses_and_legislature_label.html_safe
  end
end
