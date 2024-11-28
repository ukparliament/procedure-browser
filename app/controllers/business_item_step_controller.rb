class BusinessItemStepController < ApplicationController

  # We include modules required to steps for a business item.
  include Sparql::Get::BusinessItemSteps
  include Sparql::Queries::BusinessItemSteps
  include Sparql::Get::Response

  def index
    business_item_id = params[:business_item]
    @business_item_steps = get_business_item_steps( business_item_id )
    
    @business_item = BusinessItem.new
    @business_item.identifier = @business_item_steps.first.event_identifier
    @business_item.date = @business_item_steps.first.event_date
    @business_item.link = @business_item_steps.first.event_link
    
    if @business_item.date
      @page_title = "Steps actualised by a business item taking place on #{@business_item.date.strftime( $DATE_DISPLAY_FORMAT )}"
      @multiline_page_title = "A business item taking place on #{@business_item.date.strftime( $DATE_DISPLAY_FORMAT )} <span class='subhead'>Steps</span>".html_safe
      @description = "Steps actualised by a business item taking place on #{@business_item.date.strftime( $DATE_DISPLAY_FORMAT )}."
    else
      @page_title = "Steps actualised by a business item"
      @multiline_page_title = "A business item <span class='subhead'>Steps</span>".html_safe
      @description = "Steps actualised by a business item."
    end
    
    @crumb << { label: 'Business item', url: business_item_show_url }
    @crumb << { label: 'Steps', url: nil }
    @section = 'work-packages'
  end
end
