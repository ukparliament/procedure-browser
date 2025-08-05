class StepBusinessItemController < ApplicationController

  # We include modules required to get a step and the work packages for a step.
  include Sparql::Get::Step
  include Sparql::Queries::Step
  include Sparql::Get::StepBusinessItems
  include Sparql::Queries::StepBusinessItems
  include Sparql::Get::Response

  def index
    step_id = params[:step]
    @step = get_step( step_id )
    @step_business_items = get_step_business_items( step_id )
    
    @page_title = "#{@step.label} - Business items"
    @multiline_page_title = "#{@step.label} <span class='subhead'>Business items</span>".html_safe
    @description = "Business items for #{@step.label}."
    @rss_url = step_business_item_list_url( :format => 'rss' )
    @csv_url = step_business_item_list_url( :format => 'csv' )
    @crumb << { label: 'Steps', url: step_type_list_url }
    @crumb << { label: @step.step_type_label, url: step_type_show_url( :step_type => @step.step_type_id ) }
    @crumb << { label: @step.label, url: step_show_url }
    @crumb << { label: 'Business items', url: nil }
    @section = 'steps'
    @subsection = 'business-items'
  end
end
