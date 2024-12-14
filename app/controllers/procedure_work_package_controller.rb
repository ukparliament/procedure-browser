class ProcedureWorkPackageController < ApplicationController

  # We include modules required to get a procedure and the step types for a procedure.
  include Sparql::Get::Procedure
  include Sparql::Queries::Procedure
  include Sparql::Get::ProcedureWorkPackageCount
  include Sparql::Queries::ProcedureWorkPackageCount
  include Sparql::Get::ProcedureWorkPackages
  include Sparql::Queries::ProcedureWorkPackages
  include Sparql::Get::Response

  def index
  
    # We get the procedure.
    procedure_id = params[:procedure]
    @procedure = get_procedure( procedure_id )
  
    # We get the page number passed as a parameter.
    page = params['page']
    @page = ( page || "1" ).to_i
    
    # We get the number of results per page passed as a parameter.
    results_per_page = params['results-per-page']
    @results_per_page = ( results_per_page || $DEFAULT_RESULTS_PER_PAGE ).to_i
    
    # We get the count of all work packages in the procedure.
    @result_count = get_procedure_work_package_count( procedure_id )
    
    # If the number of the first work package on this page exceeds the total number of work packages ...
    if ( ( @page - 1 ) * @results_per_page ) + 1 > @result_count
      raise ActionController::RoutingError.new("Not Found")
    end
    
    # We get the set of work packages for this procedure on this page with this many results per page.
    @work_packages = get_procedure_work_packages( procedure_id, @page, @results_per_page )
    
    @page_title = "#{@procedure.label} - Work packages"
    @multiline_page_title = "#{@procedure.label} <span class='subhead'>Work packages</span>".html_safe
    @description = "Work packages subject to #{@procedure.label}."
    @rss_url = procedure_work_package_list_url( :format => 'rss' )
    @crumb << { label: 'Procedures', url: procedure_list_url }
    @crumb << { label: @procedure.label, url: procedure_show_url }
    @crumb << { label: 'Work packages', url: nil }
    @section = 'procedures'
    @subsection = 'work-packages'
  end
end
