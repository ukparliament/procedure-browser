module WorkPackageableThingHelper
  
  def step_work_packageable_thing_label( work_packageable_thing )
    work_packageable_thing.label
  end
  
  def step_work_packageable_thing_description( work_packageable_thing )
    step_work_packageable_thing_description = ''
    if work_packageable_thing.event_date
      step_work_packageable_thing_description += "On #{work_packageable_thing.event_date.strftime( $DATE_DISPLAY_FORMAT )}, as part of a "
    else
      step_work_packageable_thing_description += 'Part of a '
    end
    step_work_packageable_thing_description += link_to( 'work package', work_package_show_url( :work_package => work_packageable_thing.work_package_id ) )
    step_work_packageable_thing_description += ' subject to the '
    step_work_packageable_thing_description += link_to( work_packageable_thing.procedure_label, procedure_show_url( :procedure => work_packageable_thing.procedure_id ) )
    step_work_packageable_thing_description += ' procedure.'
    step_work_packageable_thing_description.html_safe
  end
end
