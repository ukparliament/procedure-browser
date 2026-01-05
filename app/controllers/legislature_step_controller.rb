class LegislatureStepController < ApplicationController

  # We include modules required to get a legislature and the steps in a legislature.
  include Sparql::Get::Legislature
  include Sparql::Queries::Legislature
  include Sparql::Get::LegislatureSteps
  include Sparql::Queries::LegislatureSteps
  include Sparql::Get::Response

  def index
    legislature_id = params[:legislature]
    @legislature = get_legislature( legislature_id )
    
    # If we find a legislature with this identifier ...
    if @legislature
    
      @steps = get_legislature_steps( legislature_id )
    
      @page_title = "Steps in the #{@legislature.label}"
    
      respond_to do |format|
        format.csv {
          response.headers['Content-Disposition'] = "attachment; filename=\"#{csv_title_from_page_title ( @page_title )}.csv\""
          render :template => 'step/index'
        }
        format.html {
          @multiline_page_title = "#{@legislature.label} <span class='subhead'>Steps</span>".html_safe
          @canonical_url = legislature_show_url
          @csv_url = legislature_step_list_url( :format => 'csv' )
          @description = "Steps in the #{@legislature.label}."
          @crumb << { label: 'Legislatures', url: legislature_list_url }
          @crumb << { label: @legislature.label, url: legislature_show_url }
          @crumb << { label: 'Steps', url: nil }
          @section = 'legislatures'
        }
      end
    end
  end
end
