class StepNoteController < ApplicationController

  # We include modules required to get a step.
  include Sparql::Get::Step
  include Sparql::Queries::Step
  include Sparql::Get::Response

  def index
    step_id = params[:step]
    @step = get_step( step_id )
  
    @page_title = '@step.display_label = Notes'
    @multiline_page_title = "#{@step.label} <span class='subhead'>Notes</span>".html_safe
    @description = "Notes for #{@step.display_label}."
    @crumb << { label: 'Steps', url: step_type_list_url }
    @crumb << { label: @step.step_type_label, url: step_type_show_url( :step_type => @step.step_type_id ) }
    @crumb << { label: @step.label, url: step_show_url }
    @crumb << { label: 'Notes', url: nil }
    @section = 'steps'
    @subsection = 'notes'
  end
end
