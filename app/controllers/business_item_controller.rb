class BusinessItemController < ApplicationController

  # We include modules required to steps for a business item.
  include Sparql::Get::BusinessItemSteps
  include Sparql::Queries::BusinessItemSteps
  include Sparql::Get::Response

  def index
  end
  
  def show
    business_item_id = params[:business_item]
    @business_item_steps = get_business_item_steps( business_item_id )
    
    @business_item = BusinessItem.new
    @business_item.identifier = @business_item_steps.first.business_item_identifier
    @business_item.date = @business_item_steps.first.business_item_date
    @business_item.link = @business_item_steps.first.business_item_link
    
    if @business_item.date
      @page_title = "A business item taking place on #{@business_item.date.strftime( $DATE_DISPLAY_FORMAT )}"
      @description = "A business item taking place on #{@business_item.date.strftime( $DATE_DISPLAY_FORMAT )}."
    else
      @page_title = "A business item"
      @description = "A business item."
    end
    @crumb << { label: 'Business item', url: nil }
    @section = 'work-packages'
  end
end
