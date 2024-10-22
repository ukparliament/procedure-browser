class StepClockController < ApplicationController

  # We include modules required to get a step and the procedures for a step.
  include Sparql::Get::Step
  include Sparql::Queries::Step
  include Sparql::Get::StepClocks
  include Sparql::Queries::StepClocks
  include Sparql::Get::Response

  def index
    step_id = params[:step]
    @step = get_step( step_id )
    @step_clocks = get_step_clocks( step_id )
    
    @page_title = "#{@step.label} - Clocks"
    @multiline_page_title = "#{@step.label} <span class='subhead'>Clocks</span>".html_safe
    @description = "Clocks for #{@step.label}."
    @crumb << { label: 'Steps', url: step_type_list_url }
    @crumb << { label: @step.step_type_label, url: step_type_show_url( :step_type => @step.step_type_id ) }
    @crumb << { label: @step.label, url: step_show_url }
    @crumb << { label: 'Clocks', url: nil }
    @section = 'steps'
    @subsection = 'clocks'
  end
end
