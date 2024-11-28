module StepClockHelper

  def step_clock_description( clock )
    clock_description = ''
    if clock.day_count
      clock_description += clock.day_count
      clock_description += ' days from '
    else
      clock_description += 'From '
    end
    clock_description += step_clock_from_step_label( clock )
    clock_description += ' to '
    clock_description += step_clock_to_step_label( clock )
    clock_description += ' as part of the '
    clock_description += link_to( clock.procedure_label, procedure_show_url( :procedure => clock.procedure_id ) )
    clock_description += ' procedure.'
    clock_description.html_safe
  end
  
  def step_clock_from_step_label( clock )
    clock_from_step_label = clock.from_step_label
    clock_from_step_label += " #{clock.from_step_type_label}" unless clock.from_step_type_id == 'Jwc6nqJi'
    clock_from_step_label += " (#{step_clock_from_step_houses_and_legislature_label( clock )})" unless step_clock_from_step_houses_and_legislature_label( clock ).empty?
    clock_from_step_label = link_to( clock_from_step_label, step_show_url( :step => clock.from_step_id ) )
    clock_from_step_label
  end
  
  def step_clock_from_step_houses_and_legislature_label( clock )
    houses_and_legislatures = []
    step_clock_from_step_houses_and_legislature_label = ''
    if clock.from_step_commons_identifier
      houses_and_legislatures << 'House of Commons'
    end
    if clock.from_step_lords_identifier
      houses_and_legislatures << 'House of Lords'
    end
    if clock.from_step_legislature_identifier
      houses_and_legislatures << clock.from_step_legislature_label
    end
    
    houses_and_legislatures.each do |hl|
      if hl != houses_and_legislatures.first
        if hl != houses_and_legislatures.last
          step_clock_from_step_houses_and_legislature_label += ', '
        else
          step_clock_from_step_houses_and_legislature_label += ' and '
        end
      end
      step_clock_from_step_houses_and_legislature_label += hl
    end
      
    step_clock_from_step_houses_and_legislature_label.html_safe
  end
  
  def step_clock_to_step_label( clock )
    clock_to_step_label = clock.to_step_label
    clock_to_step_label += " #{clock.to_step_type_label}" unless clock.to_step_type_id == 'Jwc6nqJi'
    clock_to_step_label += " (#{step_clock_to_step_houses_and_legislature_label( clock )})" unless step_clock_to_step_houses_and_legislature_label( clock ).empty?
    clock_to_step_label = link_to( clock_to_step_label, step_show_url( :step => clock.to_step_id ) )
    clock_to_step_label
  end
  
  def step_clock_to_step_houses_and_legislature_label( clock )
    houses_and_legislatures = []
    step_clock_to_step_houses_and_legislature_label = ''
    if clock.to_step_commons_identifier
      houses_and_legislatures << 'House of Commons'
    end
    if clock.to_step_lords_identifier
      houses_and_legislatures << 'House of Lords'
    end
    if clock.to_step_legislature_identifier
      houses_and_legislatures << clock.to_step_legislature_label
    end
    
    houses_and_legislatures.each do |hl|
      if hl != houses_and_legislatures.first
        if hl != houses_and_legislatures.last
          step_clock_to_step_houses_and_legislature_label += ', '
        else
          step_clock_to_step_houses_and_legislature_label += ' and '
        end
      end
      step_clock_to_step_houses_and_legislature_label += hl
    end
      
    step_clock_to_step_houses_and_legislature_label.html_safe
  end
end
