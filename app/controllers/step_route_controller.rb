class StepRouteController < ApplicationController

  # We include modules required to get a step and the procedures for a step.
  include Sparql::Get::Step
  include Sparql::Queries::Step
  include Sparql::Get::StepRoutes
  include Sparql::Queries::StepRoutes
  include Sparql::Get::Response

  def index
    step_id = params[:step]
    @step = get_step( step_id )
    @routes = get_step_routes( step_id )
    
    respond_to do |format|
      format.csv {
        render :template => 'route/index'
      }
      format.html{
        @page_title = "#{@step.display_label} - Routes"
        @multiline_page_title = "#{@step.display_label} <span class='subhead'>Routes</span>".html_safe
        @description = "Routes for #{@step.display_label}."
        @csv_url = step_route_list_url( :step => @step.id, :format => 'csv' )
        @crumb << { label: 'Steps', url: step_type_list_url }
        @crumb << { label: @step.step_type_label, url: step_type_show_url( :step_type => @step.step_type_id ) }
        @crumb << { label: @step.label, url: step_show_url }
        @crumb << { label: 'Routes', url: nil }
        @section = 'steps'
        @subsection = 'routes'
      }
    end
  end
end
