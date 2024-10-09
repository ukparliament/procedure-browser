# We require the module files for getting a step and getting work packageable things for a step.
require 'sparql/get/step'
require 'sparql/get/step_work_packageable_things'

class StepWorkPackageableThingController < ApplicationController

  # We include the get step and get step work packageable things modules.
  include GET_STEP
  include GET_STEP_WORK_PACKAGEABLE_THINGS

  def index
    step_id = params[:step]
    @step = get_step( step_id )
    @step_work_packageable_things = get_step_work_packageable_things( step_id )
    
    @page_title = "#{@step.label} - work packageable things"
    @multiline_page_title = "#{@step.label} <span class='subhead'>Work packageable things</span>".html_safe
    @description = "Work packageable things for #{@step.label}."
    @crumb << { label: 'Steps', url: step_list_url }
    @crumb << { label: @step.label, url: step_show_url }
    @crumb << { label: 'Work packageable things', url: nil }
    @section = 'steps'
    @subsection = 'work-packageable-things'
  end
end
