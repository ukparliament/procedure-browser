class BusinessItemStepController < ApplicationController

  # We include modules required to steps for a business item.
  include Sparql::Get::BusinessItemSteps
  include Sparql::Queries::BusinessItemSteps
  include Sparql::Get::Response

  def index
    business_item_id = params[:business_item]
    @business_item_steps = get_business_item_steps( business_item_id )
  
    @business_item = BusinessItem.new
    @business_item.identifier = @business_item_steps.first.business_item_identifier
    @business_item.date = @business_item_steps.first.business_item_date
    @business_item.link = @business_item_steps.first.business_item_link
    @business_item.work_package_identifier = @business_item_steps.first.work_package_identifier
    @business_item.work_packageable_thing_identifier = @business_item_steps.first.work_packageable_thing_identifier
    @business_item.work_packageable_thing_label = @business_item_steps.first.work_packageable_thing_label
    @business_item.work_package_made_available_on = @business_item_steps.first.work_package_made_available_on.to_date if @business_item_steps.first.work_package_made_available_on
    @business_item.procedure_identifier = @business_item_steps.first.procedure_identifier
    @business_item.procedure_label = @business_item_steps.first.procedure_label
    @business_item.calculation_style_identifier = @business_item_steps.first.calculation_style_identifier
    @business_item.calculation_style_label = @business_item_steps.first.calculation_style_label
  
  
    @crumb << { label: 'Work packages', url: work_package_list_url }
    @crumb << { label: @business_item.work_packageable_thing_label, url: work_package_show_url( :work_package => @business_item.work_package_identifier ) }
    if @business_item.date
      @page_title = "Work package for #{@business_item.work_packageable_thing_label} - Steps for a business item on #{@business_item.date.strftime( $DATE_DISPLAY_FORMAT )}"
      @multiline_page_title = "#{@business_item.work_packageable_thing_label} <span class='subhead'>Work package - Steps for a business item on #{@business_item.date.strftime( $DATE_DISPLAY_FORMAT )}</span>".html_safe
      @description = "Steps for a business item taking place on #{@business_item.date.strftime( $DATE_DISPLAY_FORMAT )} as part of a work package for #{@business_item.work_packageable_thing_label}."
      @crumb << { label: "Steps for a business item on #{@business_item.date.strftime( $DATE_DISPLAY_FORMAT )}", url: business_item_show_url }
    else
      @page_title = "Work package for #{@business_item.work_packageable_thing_label} - Steps for a business item"
      @multiline_page_title = "#{@business_item.work_packageable_thing_label} <span class='subhead'>Work package - Steps for a business item</span>".html_safe
      @description = "Steps for a business item as part of a work package for #{@business_item.work_packageable_thing_label}."
      @crumb << { label: 'Business item', url: business_item_show_url }
    end
    @crumb << { label: 'Steps', url: nil }
    @section = 'work-packages'
  end
end
