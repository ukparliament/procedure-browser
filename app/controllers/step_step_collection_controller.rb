# We require the module files for getting a step and getting work packageable things for a step.
require 'sparql/get/step'
require 'sparql/get/step_step_collections'

class StepStepCollectionController < ApplicationController

  # We include the get step and get step step collections modules.
  include GET_STEP
  include GET_STEP_STEP_COLLECTIONS

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
