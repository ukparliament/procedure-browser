module StepHelper

  def step_houses_and_legislature_label_with_links( step )
    houses_and_legislatures = []
    step_houses_and_legislature_label = ''
    if step.commons_identifier
      houses_and_legislatures << link_to( 'House of Commons', house_show_url( :house => step.commons_id ) )
    end
    if step.lords_identifier
      houses_and_legislatures << link_to( 'House of Lords', house_show_url( :house => step.lords_id ) )
    end
    if step.legislature_identifier
      houses_and_legislatures << link_to( step.legislature_label, legislature_show_url( :legislature => step.legislature_id ) )
    end
    
    houses_and_legislatures.each do |hl|
      if hl != houses_and_legislatures.first
        if hl != houses_and_legislatures.last
          step_houses_and_legislature_label += ', '
        else
          step_houses_and_legislature_label += ' and '
        end
      end
      step_houses_and_legislature_label += hl
    end
      
    step_houses_and_legislature_label.html_safe
  end
  
  def step_houses_and_legislature_label( step )
    houses_and_legislatures = []
    step_houses_and_legislature_label = ''
    if step.commons_identifier
      houses_and_legislatures << 'House of Commons'
    end
    if step.lords_identifier
      houses_and_legislatures << 'House of Lords'
    end
    if step.legislature_identifier
      houses_and_legislatures << step.legislature_label
    end
    
    houses_and_legislatures.each do |hl|
      if hl != houses_and_legislatures.first
        if hl != houses_and_legislatures.last
          step_houses_and_legislature_label += ', '
        else
          step_houses_and_legislature_label += ' and '
        end
      end
      step_houses_and_legislature_label += hl
    end
      
    step_houses_and_legislature_label.html_safe
  end
  
  def step_label_in_list( step )
    step_label_in_list = step.label
    step_label_in_list += " #{step.step_type_label}" unless step.step_type_id == 'Jwc6nqJi'
    step_label_in_list += " (#{step_houses_and_legislature_label( step )})" unless step_houses_and_legislature_label( step ).empty?
    step_label_in_list.html_safe
  end
  
  def step_label_with_linked_houses_and_legislatures( step )
    step_label_with_linked_houses_and_legislatures = step.step_label
    unless step_houses_and_legislature_label_with_links( step ).blank?
      step_label_with_linked_houses_and_legislatures += ' (' + step_houses_and_legislature_label_with_links( step ) + ')'
    end
    step_label_with_linked_houses_and_legislatures.html_safe
  end
    
end
