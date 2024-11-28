module StepBusinessItemHelper

  def step_business_item_description( business_item )
    step_business_item_description = ''
    if business_item.date
      step_business_item_description += "On #{business_item.date.strftime( $DATE_DISPLAY_FORMAT )}, as part"
    else
      step_business_item_description += 'Part'
    end
    step_business_item_description += ' of a work package subject to the '
    step_business_item_description += link_to( business_item.procedure_label, procedure_show_url( :procedure => business_item.procedure_id ) )
    step_business_item_description += ' procedure.'
    step_business_item_description.html_safe
  end
end
