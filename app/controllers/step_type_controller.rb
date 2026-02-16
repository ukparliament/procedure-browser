class StepTypeController < ApplicationController

  # We include modules required to get all step types and a step type with its steps.
  include Sparql::Get::StepTypes
  include Sparql::Queries::StepTypes
  include Sparql::Get::StepTypeSteps
  include Sparql::Queries::StepTypeSteps
  include Sparql::Get::Response
  
  def index
    @step_types = get_step_types

    @page_title = 'Steps - by type'
    @multiline_page_title = "Steps <span class='subhead'>By type</span>".html_safe
    @description = 'Procedure steps.'
    @crumb << { label: 'Steps', url: nil }
    @section = 'step-types'
  end
  
  def show
    step_type_id = params[:step_type]
    @steps = get_step_type_steps( step_type_id )
    
    # If we find steps for a step type with this identifier ...
    set_up_rest_of_page if @steps
  end

  def search
    @search_term = params[:search]
    step_type_id = params[:step_type]

    step_type_identifier = "https://id.parliament.uk/#{step_type_id}"

    @steps = Step.where(step_type_identifier: step_type_identifier).fuzzy_search(@search_term)
    @result_count = @steps.size

    set_up_rest_of_page if @steps
  end

  private

  def set_up_rest_of_page
    @step_type = StepType.new
    @step_type.identifier = @steps.first.step_type_identifier
    @step_type.label = @steps.first.step_type_label
    @step_type.description = @steps.first.step_type_description

    @page_title = @step_type.label
    @description = "Steps of type #{@step_type.label}."
    @csv_url = step_type_step_list_url( :format => 'csv' )
    @crumb << { label: 'Steps', url: step_type_list_url }
    @crumb << { label: @step_type.label, url: nil }
    @section = 'step-types'

    render 'step_type_step/index'
  end
end
