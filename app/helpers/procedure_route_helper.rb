module ProcedureRouteHelper

  def procedure_route_title( route )
    route_title = 'A '
    route_title += link_to( 'Route', route_show_url( :route => route.id ) )
    route_title += ' from '
    route_title += procedure_route_from_step_label( route )
    route_title += ' to '
    route_title += procedure_route_to_step_label( route )
    route_title.html_safe
  end
  
  def procedure_route_from_step_label( route )
    route_from_step_label = route.from_step_label
    route_from_step_label += " #{route.from_step_type_label}" unless route.from_step_type_id == 'Jwc6nqJi'
    route_from_step_label += " (#{route_from_step_houses_and_legislature_label( route )})" unless route_from_step_houses_and_legislature_label( route ).empty?
    if route.from_step_type_id == 'Jwc6nqJi'
      route_from_step_label = link_to( route_from_step_label, procedure_step_show_url( :step => route.from_step_id ) )
    end
    route_from_step_label
  end
  
  def procedure_route_to_step_label( route )
    route_to_step_label = route.to_step_label
    route_to_step_label += " #{route.to_step_type_label}" unless route.to_step_type_id == 'Jwc6nqJi'
    route_to_step_label += " (#{route_to_step_houses_and_legislature_label( route )})" unless route_to_step_houses_and_legislature_label( route ).empty?
    if route.to_step_type_id == 'Jwc6nqJi'
      route_to_step_label = link_to( route_to_step_label, procedure_step_show_url( :step => route.to_step_id ) )
    end
    route_to_step_label
  end
end
