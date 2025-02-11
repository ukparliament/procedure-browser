class StepCollectionWorkPackageController < ApplicationController

  # We include modules required to get a step collection and work packages for a step collection.
  include Sparql::Get::StepCollection
  include Sparql::Queries::StepCollection
  include Sparql::Get::StepCollectionWorkPackages
  include Sparql::Queries::StepCollectionWorkPackages
  include Sparql::Get::Response

  def index
    step_collection_id = params[:step_collection]
    @step_collection = get_step_collection( step_collection_id )
    @step_collection_work_packages = get_step_collection_work_packages( step_collection_id )
    
    @page_title = "#{@step_collection.label} - Work packages"
    @multiline_page_title = "#{@step_collection.label} <span class='subhead'>Work packages</span>".html_safe
    @description = "Work packages with business items actualising one or more steps in the '#{@step_collection.label}' step collection."
    @crumb << { label: 'Step collections', url: step_collection_list_url }
    @crumb << { label: @step_collection.label, url: step_collection_show_url }
    @crumb << { label: 'Work packages', url: nil }
    @section = 'step-collections'
    @subsection = 'work-packages'
  end
end
