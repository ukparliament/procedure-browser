module ProcedureClockHelper

  def procedure_clock_description( clock )
    clock_description = ''
    if clock.day_count
      clock_description += clock.day_count
      clock_description += ' days from '
    else
      clock_description += 'From '
    end
    clock_description += procedure_clock_from_step_label( clock )
    clock_description += ' to '
    clock_description += procedure_clock_to_step_label( clock )
    clock_description += '.'
    clock_description.html_safe
  end
  
  def procedure_clock_from_step_label( clock )
    clock_from_step_label = clock.from_step_label
    clock_from_step_label += " #{clock.from_step_type_label}" unless clock.from_step_type_id == 'Jwc6nqJi'
    clock_from_step_label += " (#{step_clock_from_step_houses_and_legislature_label( clock )})" unless step_clock_from_step_houses_and_legislature_label( clock ).empty?
    clock_from_step_label = link_to( clock_from_step_label, procedure_step_show_url( :step => clock.from_step_id ) ) if clock.from_step_type_id == 'Jwc6nqJi'
    clock_from_step_label
  end
  
  def procedure_clock_to_step_label( clock )
    clock_to_step_label = clock.to_step_label
    clock_to_step_label += " #{clock.to_step_type_label}" unless clock.to_step_type_id == 'Jwc6nqJi'
    clock_to_step_label += " (#{step_clock_to_step_houses_and_legislature_label( clock )})" unless step_clock_to_step_houses_and_legislature_label( clock ).empty?
    clock_to_step_label = link_to( clock_to_step_label, procedure_step_show_url( :step => clock.to_step_id ) ) if clock.from_step_type_id == 'Jwc6nqJi'
    clock_to_step_label
  end
end
