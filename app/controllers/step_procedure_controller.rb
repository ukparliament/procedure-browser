class StepProcedureController < ApplicationController

  # We include modules required to get a step and the procedures for a step.
  include Sparql::Get::Step
  include Sparql::Queries::Step
  include Sparql::Get::StepProcedures
  include Sparql::Queries::StepProcedures
  include Sparql::Get::Response

  def index
    step_id = params[:step]
    @step = get_step( step_id )
    @step_procedures = get_step_procedures( step_id )
    
    @page_title = "#{@step.display_label} - Procedures"
    @multiline_page_title = "#{@step.display_label} <span class='subhead'>Procedures</span>".html_safe
    @description = "Procedures for #{@step.display_label}."
    @crumb << { label: 'Steps', url: step_type_list_url }
    @crumb << { label: @step.step_type_label, url: step_type_show_url( :step_type => @step.step_type_id ) }
    @crumb << { label: @step.label, url: step_show_url }
    @crumb << { label: 'Procedures', url: nil }
    @section = 'steps'
    @subsection = 'procedures'
  end
end
