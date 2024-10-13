class StepWorkPackageableThingController < ApplicationController

  # We include modules required to get a step and the work packages for a step.
  include Sparql::Get::Step
  include Sparql::Queries::Step
  include Sparql::Get::StepWorkPackageableThings
  include Sparql::Queries::StepWorkPackageableThings
  include Sparql::Get::Response

  def index
    step_id = params[:step]
    @step = get_step( step_id )
    @step_work_packageable_things = get_step_work_packageable_things( step_id )
    
    @page_title = "#{@step.label} - Papers"
    @multiline_page_title = "#{@step.label} <span class='subhead'>Papers</span>".html_safe
    @description = "Papers for #{@step.label}."
    @rss_url = step_work_packageable_thing_list_url( :format => 'rss' )
    @crumb << { label: 'Steps', url: step_type_list_url }
    @crumb << { label: @step.step_type_label, url: step_type_show_url( :step_type => @step.step_type_id ) }
    @crumb << { label: @step.label, url: step_show_url }
    @crumb << { label: 'Papers', url: nil }
    @section = 'steps'
    @subsection = 'work-packageable-things'
  end
end
