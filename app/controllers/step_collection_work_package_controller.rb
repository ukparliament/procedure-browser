class StepCollectionWorkPackageController < ApplicationController

  # We include modules required to get a step collection and work packages for a step collection.
  include Sparql::Get::StepCollection
  include Sparql::Queries::StepCollection
  include Sparql::Get::StepCollectionWorkPackageCount
  include Sparql::Queries::StepCollectionWorkPackageCount
  include Sparql::Get::StepCollectionWorkPackages
  include Sparql::Queries::StepCollectionWorkPackages
  include Sparql::Get::Response

  def index
  
    # We get the step collection.
    step_collection_id = params[:step_collection]
    @step_collection = get_step_collection( step_collection_id )
  
    # We get the page number passed as a parameter.
    page = params['page']
    @page = ( page || "1" ).to_i
    
    # We get the number of results per page passed as a parameter.
    results_per_page = params['results-per-page']
    @results_per_page = ( results_per_page || $DEFAULT_RESULTS_PER_PAGE ).to_i
    
    # We get the count of all work packages having actualised steps from the step collection.
    @result_count = get_step_collection_work_package_count( step_collection_id )
    
    # If this is not the first page and the number of the first work package on this page exceeds the total number of work packages ...
    if @page != 1 && ( ( ( @page - 1 ) * @results_per_page ) + 1 > @result_count )
      raise ActionController::RoutingError.new("Not Found")
    end
    
    # We get the set of work packages for this step collection on this page with this many results per page.
    @work_packages = get_step_collection_work_packages( step_collection_id, @page, @results_per_page )
    
    @page_title = "#{@step_collection.label} - Work packages"
    @multiline_page_title = "#{@step_collection.label} <span class='subhead'>Work packages</span>".html_safe
    @description = "Work packages with business items actualising one or more steps in the '#{@step_collection.label}' step collection."
    @rss_url = step_collection_work_package_list_url( :format => 'rss' )
    @crumb << { label: 'Step collections', url: step_collection_list_url }
    @crumb << { label: @step_collection.label, url: step_collection_show_url }
    @crumb << { label: 'Work packages', url: nil }
    @section = 'step-collections'
    @subsection = 'work-packages'
  end
end
