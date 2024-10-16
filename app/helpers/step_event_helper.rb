module StepEventHelper

  def step_event_description( event )
    step_event_description = ''
    if event.date
      step_event_description += "On #{event.date.strftime( $DATE_DISPLAY_FORMAT )}, as part"
    else
      step_event_description += 'Part'
    end
    step_event_description += ' of a work package subject to the '
    step_event_description += link_to( event.procedure_label, procedure_show_url( :procedure => event.procedure_id ) )
    step_event_description += ' procedure.'
    step_event_description.html_safe
  end
end
