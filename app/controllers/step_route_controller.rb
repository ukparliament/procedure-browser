class StepRouteController < ApplicationController

  # We include modules required to get a step and the procedures for a step.
  include Sparql::Get::Step
  include Sparql::Queries::Step
  #include Sparql::Get::StepRoutes
  #include Sparql::Queries::StepRoutes
  include Sparql::Get::Response

  def index
    step_id = params[:step]
    @step = get_step( step_id )
    #@step_procedures = get_step_procedures( step_id )
    
    @page_title = "#{@step.label} - Routes"
    @multiline_page_title = "#{@step.label} <span class='subhead'>Routes</span>".html_safe
    @description = "Routes for #{@step.label}."
    @crumb << { label: 'Steps', url: step_type_list_url }
    @crumb << { label: @step.step_type_label, url: step_type_show_url( :step_type => @step.step_type_id ) }
    @crumb << { label: @step.label, url: step_show_url }
    @crumb << { label: 'Routes', url: nil }
    @section = 'steps'
    @subsection = 'routes'
  end
end
