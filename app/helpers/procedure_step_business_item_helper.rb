module ProcedureStepBusinessItemHelper

  def procedure_step_business_item_description( business_item )
    procedure_step_business_item_description = ''
    if business_item.date
      procedure_step_business_item_description += "On #{business_item.date.strftime( $DATE_DISPLAY_FORMAT )}."
    end
    procedure_step_business_item_description.html_safe
  end
end
