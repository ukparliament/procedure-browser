class StepBusinessItemController < ApplicationController

  # We include modules required to get a step and the work packages for a step.
  include Sparql::Get::Step
  include Sparql::Queries::Step
  include Sparql::Get::StepBusinessItemCount
  include Sparql::Queries::StepBusinessItemCount
  include Sparql::Get::StepBusinessItems
  include Sparql::Queries::StepBusinessItems
  include Sparql::Get::StepBusinessItemsAll
  include Sparql::Queries::StepBusinessItemsAll
  include Sparql::Get::Response

  def index
  
    # We get the step.
    step_id = params[:step]
    @step = get_step( step_id )
    
    respond_to do |format|
      format.html {
        
        # We get the page number passed as a parameter.
        page = params['page']
        @page = ( page || "1" ).to_i

        # We get the number of results per page passed as a parameter.
        results_per_page = params['results-per-page']
        @results_per_page = ( results_per_page || $DEFAULT_RESULTS_PER_PAGE ).to_i

        # We get the count of business items having actualised the step.
        @result_count = get_step_business_item_count( step_id )

        # If this is not the first page and the number of the first work package on this page exceeds the total number of work packages ...
        if @page != 1 && ( ( ( @page - 1 ) * @results_per_page ) + 1 > @result_count )
          raise ActionController::RoutingError.new("Not Found")
        end

        # We get the set of current business items for this step on this page with this many results per page.
        @business_items = get_step_business_items( step_id, @page, @results_per_page )

        @page_title = "@step.display_label - Business items"
        @multiline_page_title = "#{@step.display_label} <span class='subhead'>Business items</span>".html_safe
        @description = "Business items for #{@step.display_label}."
        @rss_url = step_business_item_list_url( :format => 'rss' )
        @csv_url = step_business_item_list_url( :format => 'csv' )
        @crumb << { label: 'Steps', url: step_type_list_url }
        @crumb << { label: @step.step_type_label, url: step_type_show_url( :step_type => @step.step_type_id ) }
        @crumb << { label: @step.label, url: nil }
        @section = 'steps'
        @subsection = 'business-items'
      }
      format.csv {
        @business_items = get_step_business_items_all( step_id )
      }
      format.rss {
        @business_items = get_step_business_items_all( step_id )
      }
    end
  end
end
