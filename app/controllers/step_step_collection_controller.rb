class StepStepCollectionController < ApplicationController

  # We include modules required to get a step and the step collections for a step.
  include Sparql::Get::Step
  include Sparql::Queries::Step
  include Sparql::Get::StepStepCollections
  include Sparql::Queries::StepStepCollections
  include Sparql::Get::Response


  def index
    step_id = params[:step]
    @step = get_step( step_id )
    @step_step_collections = get_step_step_collections( step_id )
    
    @page_title = "#{@step.label} - Step collections"
    @multiline_page_title = "#{@step.label} <span class='subhead'>Step collections</span>".html_safe
    @description = "Step collections containing #{@step.label}."
    @crumb << { label: 'Steps', url: step_type_list_url }
    @crumb << { label: @step.step_type_label, url: step_type_show_url( :step_type => @step.step_type_id ) }
    @crumb << { label: @step.label, url: step_show_url }
    @crumb << { label: 'Step collections', url: nil }
    @section = 'steps'
    @subsection = 'step-collections'
  end
end
